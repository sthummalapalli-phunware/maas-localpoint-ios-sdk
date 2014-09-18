//
//  LocationFilterAggregator.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 4/3/14.
//  Copyright (c) 2014 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "LocationFilterAggregator.h"
#import "LocationFilters.h"

@implementation LocationFilterAggregator {
    @private
    NSSet *iFilters;
}

- (id)init {
    LocationFilterAggregator *me = [self initWithSet:[NSSet set]];
    [me reset];
    
    return me;
}

- (id)initWithSet:(NSSet *)filters {
    // TODO: Could validate that each item in the set conforms
    if (self = [super init]) {
        iFilters = filters;
    }
    return self;
}

- (void)reset {
    iFilters = [NSSet set];
    if ([LocationFilters getAllowsCheckinFilterState]) {
        [self addAllowsCheckinFilter];
    }
    if ([LocationFilters getDeviceIsInFilterState]) {
        [self addDeviceIsInFilter];
    }
}

- (void)resetWithSet:(NSSet *)filters {
    iFilters = filters;
}

- (void)addAllowsCheckinFilter {
    id<ILPFilter> filter = [[[[LPLocalpointService instance] getLocationProvider] getFilterFactory] getAllowsCheckInFilter];
    [self addFilter:filter];
}

- (void)addDeviceIsInFilter {
    id<ILPFilter> filter = [[[[LPLocalpointService instance] getLocationProvider] getFilterFactory] getDeviceIsInFilter];
    [self addFilter:filter];
}

- (void)addFilter:(id<ILPFilter>) filter {
    NSMutableSet *tmp = [NSMutableSet setWithSet:iFilters];
    [tmp addObject:filter];
    iFilters = [NSSet setWithSet:tmp];
}

- (BOOL)accept:(id)obj {
    if (![obj conformsToProtocol:@protocol(ILPLocation)])
        return NO;
    
    id<ILPLocation> loc = (id<ILPLocation>) obj;
    
    for (id<ILPFilter> filter in iFilters) {
        if (![filter accept:loc])
            return NO;
    }
    return YES;
}

@end
