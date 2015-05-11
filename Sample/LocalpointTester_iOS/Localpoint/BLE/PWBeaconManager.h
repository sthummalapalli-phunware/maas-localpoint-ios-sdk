//
//  PWBeaconManager.h
//  Localpoint
//
//  Created by Xiangwei Wang on 4/15/15.
//  Copyright (c) 2015 Xiangwei Wang. All rights reserved.
//
//

#import "PWBeacon.h"

extern NSString * const kPWBeaconManagerDidEnterRegionNotification;
extern NSString * const kPWBeaconManagerDidExitRegionNotification;
extern NSString * const kPWBeacon;
extern NSString * const kPWRegion;

@interface PWBeaconManager : NSObject

@property (nonatomic, strong) NSArray *localBeacons;

+ (instancetype)sharedManager;

- (void)startMonitorBeaconsInGeofence:(NSString*)outreachGeofenceId;

- (void)stopMonitorBeaconsInGeofence:(NSString*)outreachGeofenceId;

@end