//
//  PWBeaconManager.m
//  Localpoint
//
//  Created by Xiangwei Wang on 4/15/15.
//  Copyright (c) 2015 Xiangwei Wang. All rights reserved.
//
//

#import <CoreLocation/CoreLocation.h>
#import <Localpoint/Localpoint.h>
#import "PWBeaconManager.h"

// Constant Strings
#warning Replace this string with the proper URL!
NSString * const kPWLPRemoteBeaconURLString = @"https://dl.dropboxusercontent.com/u/117922424/beacons-2x.json";

NSString * const kPWRegionIdentifierPrefix = @"LP_BLE_";
NSString * const PWSavedBeaconDataKey = @"PWSavedBeaconDataKey";
NSString * const PWSavedBeaconDataDateKey = @"PWSavedBeaconDataDateKey";
NSTimeInterval const PWFetchBeaconInterval = 60 * 60 * 24; // 1 day

static int maxRequestInterval = 900;
static NSDate *lastSendTime = nil;

@interface PWBeaconManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation PWBeaconManager

#pragma mark - NSObject

+ (void)load {
    // Instantiate the singleton
    [PWBeaconManager sharedManager];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _operationQueue = [NSOperationQueue new];
        _operationQueue.name = @"com.phunware.lp.ble-download-queue";
        
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([_locationManager respondsToSelector:NSSelectorFromString(@"requestAlwaysAuthorization")]) {
            [_locationManager performSelector:NSSelectorFromString(@"requestAlwaysAuthorization") withObject:nil afterDelay:0];
        }

        [self loadBeaconsFromURL:[NSURL URLWithString:kPWLPRemoteBeaconURLString]];
    }
    
    return self;
}

#pragma mark - Singleton

+ (instancetype)sharedManager {
    static PWBeaconManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [PWBeaconManager new];
    });
    
    return sharedManager;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    PWBeacon *pwBeacon = [self covertRegionToPWBeacon:region];
    if (!pwBeacon)
        return;
    
    for (CLBeacon *beacon in beacons) {
        if (beacon.proximity == pwBeacon.proximity) {
            if (lastSendTime) {
                if (fabs([lastSendTime timeIntervalSinceNow]) < maxRequestInterval)
                    return;
            }
            
            lastSendTime = [NSDate date];
            LPEventHandler *eventHandler = [LPEventHandler new];
            [eventHandler process:LPEventTypeEntry
                       geofenceId:[self parseBLERegionId:region.identifier]
                       completion:^(NSError *error) {
                           if (error) {
                               NSLog(@"Failed sending entry event with error: %@", error);
                           }
            }];
        } else if (beacon.proximity == CLProximityUnknown) {
            LPEventHandler *eventHandler = [LPEventHandler new];
            [eventHandler process:LPEventTypeExit
                       geofenceId:[self parseBLERegionId:region.identifier]
                       completion:^(NSError *error) {
                           if (error) {
                               NSLog(@"Failed sending entry event with error: %@", error);
                           }
                       }];
            [self.locationManager stopRangingBeaconsInRegion:region];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"didEnterRegion: %@", region);
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        LPEventHandler *eventHandler = [LPEventHandler new];
        [eventHandler process:LPEventTypeExit
                   geofenceId:[self parseBLERegionId:region.identifier]
                   completion:^(NSError *error) {
                       if (error) {
                           NSLog(@"Failed sending entry event with error: %@", error);
                       }
                   }];
        [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

#pragma mark - Public

- (void)startMonitorBeaconsInGeofence:(NSString*)outreachGeofenceId {
    NSArray *clBeacons = [self getBeaconsInGeofence:outreachGeofenceId];
    
    if (clBeacons && clBeacons.count > 0) {
        [self startMonitoringRegions:clBeacons delay:1];
    }
}

- (void)stopMonitorBeaconsInGeofence:(NSString*)outreachGeofenceId {
    NSArray *clBeacons = [self getBeaconsInGeofence:outreachGeofenceId];
    
    if (clBeacons && clBeacons.count > 0) {
        for (CLBeaconRegion *beacon in clBeacons) {
            [self.locationManager stopMonitoringForRegion:beacon];
        }
    }
}

#pragma mark - Internal

- (NSArray*)getBeaconsInGeofence:(NSString*)outreachGeofenceId {
    NSMutableArray *clBeacons = [NSMutableArray new];
    for (PWBeacon *pwBeacon in self.localBeacons) {
        if ([pwBeacon.outreachIdentifier isEqualToString:outreachGeofenceId]) {
            [clBeacons addObject:pwBeacon.beaconRegion];
        }
    }
    return clBeacons;
}

- (PWBeacon*)covertRegionToPWBeacon:(CLBeaconRegion*)region {
    for (PWBeacon *pwBeacon in self.localBeacons) {
        if ([pwBeacon.beaconRegion isEqual:region]) {
            return pwBeacon;
        }
    }
    
    return nil;
}

- (void)startMonitoringRegions:(NSArray *)beaconRegionsToMonitor delay:(NSTimeInterval)delay {
    __weak __typeof(self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Delay monitoring regions so internal localpoint SDK can do it's thing
        if (self.locationManager.monitoredRegions.count + beaconRegionsToMonitor.count >= 20) {
            NSInteger delta = 20 - (weakSelf.locationManager.monitoredRegions.count + beaconRegionsToMonitor.count);
            
            // Determine outside regions
            NSMutableArray *outsideRegions = [NSMutableArray array];
            
            for (CLRegion *region in weakSelf.locationManager.monitoredRegions) {
                if (![region isKindOfClass:[CLBeaconRegion class]]) {
                    if (![region containsCoordinate:weakSelf.locationManager.location.coordinate]) {
                        [outsideRegions addObject:region];
                    }
                }
            }
            
            if (outsideRegions.count >= delta) {
                while (delta > 0) {
                    [weakSelf.locationManager stopMonitoringForRegion:[outsideRegions lastObject]];
                    delta--;
                }
            } else {
                // Remove all outside regions
                for (CLRegion *region in outsideRegions) {
                    [weakSelf.locationManager stopMonitoringForRegion:region];
                    
                    delta--;
                }
                
                // TO DO: Trim out delta# regions (which ones ?)
            }
        }
        
        if (beaconRegionsToMonitor.count > 0) {
            [weakSelf monitorBeacons:beaconRegionsToMonitor];
        }
    });
}

- (void)monitorBeacons:(NSArray *)beacons {
    // Register for region monitoring
    for (CLBeaconRegion *beacon in beacons) {
        [self.locationManager startMonitoringForRegion:beacon];
    }
}

- (NSString*) parseBLERegionId:(NSString*)regionId {
    NSArray *array = [regionId componentsSeparatedByString:kPWRegionIdentifierPrefix];
    if (array.count == 2) {
        return [array objectAtIndex:1];
    } else {
        return nil;
    }
}

#pragma mark - Beacons

- (void)loadLocalBeaconsFromFile {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ae_beacons" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    NSArray *beaconObjects = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) {
        NSLog(@"Error loading beacons.json!");
    } else {
        NSArray *beacons = [self loadBeaconsFromObjectArray:beaconObjects];
        
        self.localBeacons = beacons;
    }
}

- (void)loadBeaconsFromURL:(NSURL *)url {
    if (!url) {
        [self loadLocalBeaconsFromFile];
        return;
    }
    
    // Check the last time beacon information was downloaded
    NSDate *lastDownloadDate = [[NSUserDefaults standardUserDefaults] objectForKey:PWSavedBeaconDataDateKey];
    
    if ([lastDownloadDate timeIntervalSinceNow] > PWFetchBeaconInterval && lastDownloadDate != nil) {
        // The file we have is still good
        [self loadBeaconsFromUserDefaultsOrFile];
        return;
    }

    __weak __typeof(self)weakSelf = self;
    
    // Build the request
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    // Send the request and default to a local file if an error occurs
    [NSURLConnection sendAsynchronousRequest:request queue:self.operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Error loading beacons! -> %@", connectionError);
            [weakSelf loadBeaconsFromUserDefaultsOrFile];
        } else {
            NSError *error = nil;
            NSArray *beaconObjects = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error) {
                NSLog(@"Error loading beacons! -> %@", error);
                [weakSelf loadBeaconsFromUserDefaultsOrFile];
            } else {
                NSArray *beacons = [self loadBeaconsFromObjectArray:beaconObjects];
                weakSelf.localBeacons = beacons;
                
                // Save the beacons the NSUserDefaults
                [[NSUserDefaults standardUserDefaults] setObject:beaconObjects.copy forKey:PWSavedBeaconDataKey];
                [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:PWSavedBeaconDataDateKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    }];
}

- (void)loadBeaconsFromUserDefaultsOrFile {
    NSArray *savedBeacons = [[NSUserDefaults standardUserDefaults] objectForKey:PWSavedBeaconDataKey];
    
    if (savedBeacons) {
        NSArray *beacons = [self loadBeaconsFromObjectArray:savedBeacons];
        self.localBeacons = beacons;
    } else {
        [self loadLocalBeaconsFromFile];
    }
}

- (NSArray *)loadBeaconsFromObjectArray:(NSArray *)beaconObjects {
    NSMutableArray *beacons = [NSMutableArray array];
    
    for (NSDictionary *beaconObject in beaconObjects) {
        PWBeacon *beacon = [PWBeacon new];
        beacon.name = beaconObject[@"name"];
        beacon.identifier = beaconObject[@"geofenceId"];
        beacon.outreachIdentifier = beaconObject[@"outreachGeofenceId"];
        beacon.proximity = [beaconObject[@"proximity"] integerValue];
        
        NSDictionary *beaconData = beaconObject[@"beacon"];
        
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:beaconData[@"uuid"]];
        
        if (!uuid) {
            NSLog(@"Error unpacking UUID! -> %@", beaconData[@"uuid"]);
            continue;
        }
        
        beacon.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                      major:[beaconData[@"major"] integerValue]
                                                                      minor:[beaconData[@"minor"] integerValue]
                                                                 identifier:beacon.identifier];
        [beacons addObject:beacon];
    }
    
    return beacons;
}

@end
