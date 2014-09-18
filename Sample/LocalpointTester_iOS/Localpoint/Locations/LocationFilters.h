//
//  LocationFilters.h
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 4/3/14.
//  Copyright (c) 2014 Jason Schmitt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationFilters : NSObject

+ (void)setAllowsCheckinFilterState:(BOOL)on;
+ (BOOL)getAllowsCheckinFilterState;

+ (void)setDeviceIsInFilterState:(BOOL)on;
+ (BOOL)getDeviceIsInFilterState;

+ (void)resetStates;

@end
