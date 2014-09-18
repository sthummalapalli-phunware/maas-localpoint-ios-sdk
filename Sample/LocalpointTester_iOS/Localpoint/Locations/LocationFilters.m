//
//  LocationFilters.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 4/3/14.
//  Copyright (c) 2014 Jason Schmitt. All rights reserved.
//

#import "LocationFilters.h"

static NSString *const ALLOWS_CHECKIN_STATE = @"LPT_AllowsCheckin";
static NSString *const DEVICE_IS_IN_STATE = @"LPT_LocationsIn";

@implementation LocationFilters

#pragma mark - Allows Checkin filter
+ (void)setAllowsCheckinFilterState:(BOOL)on {
    [LocationFilters setBool:on forKey:ALLOWS_CHECKIN_STATE];
}

+ (BOOL)getAllowsCheckinFilterState {
    return [LocationFilters getBoolForKey:ALLOWS_CHECKIN_STATE];
}

#pragma mark - Locations In filter
+ (void)setDeviceIsInFilterState:(BOOL)on {
    [LocationFilters setBool:on forKey:DEVICE_IS_IN_STATE];
}

+ (BOOL)getDeviceIsInFilterState {
    return [LocationFilters getBoolForKey:DEVICE_IS_IN_STATE];
}

+ (void)setBool:(BOOL)val forKey:(NSString *)key {
    @synchronized(self) {
        [[NSUserDefaults standardUserDefaults] setBool:val forKey:key];
    }
}

+ (BOOL)getBoolForKey:(NSString *)key {
    @synchronized(self) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:key];
    }
}

+ (void)resetStates {
    @synchronized(self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:ALLOWS_CHECKIN_STATE];
        [defaults removeObjectForKey:DEVICE_IS_IN_STATE];
    }
}

@end
