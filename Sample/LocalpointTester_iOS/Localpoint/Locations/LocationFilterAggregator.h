//
//  LocationFilterAggregator.h
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 4/3/14.
//  Copyright (c) 2014 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import <Foundation/Foundation.h>

@interface LocationFilterAggregator : NSObject <ILPFilter>

- (id)initWithSet:(NSSet *)filters;

- (void)reset;

- (void)resetWithSet:(NSSet *)filters;

- (void)addAllowsCheckinFilter;

- (void)addDeviceIsInFilter;

- (void)addFilter:(id<ILPFilter>) filter;

@end
