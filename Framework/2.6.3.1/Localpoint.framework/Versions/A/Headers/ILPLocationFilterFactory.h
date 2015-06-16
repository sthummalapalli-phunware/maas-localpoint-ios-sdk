//
//  ILPLocationFilterFactory.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPFilter;

/**
 A location filter factory provides {@link ILPFilter filters} that operate on {@link ILPLocation locations}.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPLocationFilterFactory < NSObject >

/**
 Returns a filter that accepts all locations.

 @return a filter that accepts all locations
 */
- (id<ILPFilter>)getAllFilter;

/**
 Returns a filter that accepts only those locations for which check-in has been enabled.

 @return a filter that accepts only those locations for which check-in has been enabled
 */
- (id<ILPFilter>)getAllowsCheckInFilter;

/**
 Returns a filter that accepts only those locations with the given tag.

 @param tag The tag that must be present on the locations accepted by the returned filter

 @return a filter that accepts only those locations with the given tag

 @throws IllegalArgumentException if the given tag is <code>nil</code>
 */
- (id<ILPFilter>)getHasTagFilter:(NSString *)tag;

/**
 Returns a filter that accepts only those locations that are within the given distance from the last known geopoint of the device.

 @param distance The maximum distance a location can be from the last known geopoint and still be accepted by the returned filter in meters

 @return a filter that accepts only those locations that are within the given distance from the last known geopoint of the device
 */
- (id<ILPFilter>)getWithinDistanceFilter:(int)distance;

/**
 Returns a filter that accepts only those locations that the device is currently located in according to the location marketing server.

 @return a filter that accepts only those locations that the device is currently located in according to the location marketing server.
 */
- (id<ILPFilter>)getDeviceIsInFilter;

@end
