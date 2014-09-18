//
//  ILPLocationOrderingFactory.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPOrdering;

/**
 A location ordering factory provides {@link ILPOrdering orderings} that operate on {@link ILPLocation locations}.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPLocationOrderingFactory < NSObject >

/**
 Returns a filter that sorts locations by ascending distance from the last known geopoint of the device.

 @return a filter that sorts locations by ascending distance from the last known geopoint of the device
 */
- (id<ILPOrdering>)getAscendingDistanceOrdering;

/**
 Returns a filter that sorts locations by descending distance from the last known geopoint of the device.

 @return a filter that sorts locations by descending distance from last known geopoint of the device
 */
- (id<ILPOrdering>)getDescendingDistanceOrdering;

@end
