///
//  ILPGeopoint.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

/**
 A geopoint is a coordinate in the physical world.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPGeopoint < NSObject >

/**
 Returns the latitude of this geopoint.
 
 @discussion The value returned by this method is expressed in degrees. This value should be between -90.0 and +90.0, inclusive.

 @return the latitude of this geopoint
 */
- (double)getLatitude;

/**
 Returns the longitude of this geopoint.

 @discussion The value returned by this method is expressed in degrees. This value should be between -180.0 and +180.0, inclusive.

 @return the longitude of this geopoint
 */
- (double)getLongitude;

@end

#define ComDigbyLocalpointSdkCoreILPGeopoint ILPGeopoint
