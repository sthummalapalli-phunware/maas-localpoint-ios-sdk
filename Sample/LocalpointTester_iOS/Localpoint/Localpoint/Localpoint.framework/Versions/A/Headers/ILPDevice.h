//
//  ILPDevice.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPGeopoint;
@protocol ILPID;

/**
 The device on which the application is running.
 
 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPDevice < NSObject >

/**
 Returns the identifier of this device.
 
 @return the identifier of this device
 */
- (id<ILPID>)getID;

/**
 Returns the last known position of this device.
 
 @discussion This method may return <code>nil</code> if the Localpoint SDK has not been able to determine a position of the device.
 
 @return the last known position of this device
 */
- (id<ILPGeopoint>)getLastKnownGeopoint;


/**
 Returns a Set of ILPLocation for which the device is currently in according to the Localpoint server.
 
 @return the set of locations that the device is currently in.
 */
- (NSSet *)getLocationsIn;
@end

#define ComDigbyLocalpointSdkCoreILPDevice ILPDevice
