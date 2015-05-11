//
//  PWBeacon.h
//  Localpoint
//
//  Created by Xiangwei Wang on 4/15/15.
//  Copyright (c) 2015 Xiangwei Wang. All rights reserved.
//
//

#import <CoreLocation/CoreLocation.h>

@interface PWBeacon : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *outreachIdentifier;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic) NSInteger proximity;

@end

/*
 {
 "name": "name goes here",
 "geofenceId": 123,
 "outreachGeofenceId": 456,
 "beacon": {
 "uuid": "36548401-C4CD-49EF-202A-35E5B135801C",
 "major": 15152,
 "minor": 59636
 }
 }
 */