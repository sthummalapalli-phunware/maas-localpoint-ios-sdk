//
//  ILPDevice.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPGeopoint;
@protocol ILPID;

/**
 This interface defines device on which the application is running.
 
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
 
 @discussion This method may return <code>nil</code> if the location marketing SDK has not been able to determine the position of the device.
 
 @return the last known position of this device
 */
- (id<ILPGeopoint>)getLastKnownGeopoint;


/**
 Returns a set of ILPLocation for which the device is currently located in according to the location marketing server.
 
 @return the set of locations that the device is currently in
 */
- (NSSet *)getLocationsIn;
@end

#define ComDigbyLocalpointSdkCoreILPDevice ILPDevice
