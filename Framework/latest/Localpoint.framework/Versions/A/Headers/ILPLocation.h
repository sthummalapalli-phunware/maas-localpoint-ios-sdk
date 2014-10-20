///
//  ILPLocation.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPGeopoint;
@protocol ILPID;

/**
 A location is an area of interest defined on the Localpoint console.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPLocation < NSObject >

/**
 Returns the basic service set identification (BSSID) associated with this location.

 @discussion This method may return <code>nil</code> if no BSSID is associated with this location.

 @return the basic service set identification (BSSID) associated with this location
 */
- (NSString *)getBSSID;

/**
 Returns the geopoint at the center of gravity of this location.

 @discussion This method should never return <code>nil</code>.

 @return the geopoint at the center of gravity of this location
 */
- (id<ILPGeopoint>)getCenter;

/**
 Returns a description of this location.
 
 @discussion This method should never return <code>nil</code>.

 @return a description of this location
 */
- (NSString *)getDescription;

/**
 Returns the internal unique identifier of this location.
 
 @discussion This method should never return <code>nil</code>.

 @return the internal unique identifier of this location
 */
- (id<ILPID>)getID;

/**
 Returns the externally-defined unique identifier of this location.

 @discussion This method should never return <code>nil</code>.

 @return the externally-defined unique identifier of this location
 */
- (NSString *)getCode;

/**
 Returns the name of this location.

 @discussion This method should never return <code>nil</code>.
 
 @return the name of this location
 */
- (NSString *)getName;

/**
 Returns the service set identification (SSID) associated with this location.
 
 @discussion This method may return <code>nil</code> if no SSID is associated with this location.
 
 @return the service set identification (SSID) associated with this location
 */
- (NSString *)getSSID;

/**
 Returns the set of tags associated with this location.
 
 @discussion This method should never return <code>nil</code>.

 @return the (possibly empty) set of tags associated with this location
 */
- (NSSet *)getTags;

/**
 Perform a check-in on this location.
 
 @discussion This method will check in to this location with the Localpoint server to see if there are any offers available.
 */
- (void)checkIn;

/**
 Returns whether or not the device is currently in this location.
 
 @return true if the device is currently in this location according to the Localpoint server, false otherwise.
 */
- (BOOL)isDeviceIn;

@end

#define ComDigbyLocalpointSdkCoreILPLocation ILPLocation
