//
//  ILPLocalpointService.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPDevice;
@protocol ILPLocalNotificationListener;
@protocol ILPLocationProvider;
@protocol ILPMessageProvider;
@protocol ILPUser;
@protocol ILPVersion;

/**
 The location marketing service is the applications entry point to location marketing functionality.

 @version 2.6.0
 @since 1.0.0
 */
@protocol ILPLocalpointService < NSObject >

/**
 Returns the {@link ILPDevice device} associated with the location marketing service.

 @discussion This method should never return <code>nil</code>.

 @return the {@link ILPDevice device} associated with the location marketing service
 */
- (id<ILPDevice>)getDevice;

/**
 Returns the {@link ILPUser user} of the location marketing service.

 @discussion This method should never return <code>nil</code>.

 @return the {@link ILPUser user} of the location marketing service
 */
- (id<ILPUser>)getUser;

/**
 Returns the {@link ILPLocationProvider location provider} associated with the location marketing service.
 
 @discussion This method should never return <code>nil</code>.

 @return the {@link ILPLocationProvider location provider} associated with the location marketing service
 */
- (id<ILPLocationProvider>)getLocationProvider;

/**
 Returns the {@link ILPMessageProvider message provider} associated with the location marketing service.

 @discussion This method should never return <code>nil</code>.

 @return the {@link ILPMessageProvider message provider} associated with the location marketing service
 */
- (id<ILPMessageProvider>)getMessageProvider;

/**
 Returns the version for the location marketing SDK.

 @discussion This method should never return <code>nil</code>.

 @return the version for the location marketing SDK
 */
- (id<ILPVersion>)getSDKVersion;

/**
 Indicates whether the brand identifier used by this service is enabled.

 @return <code>YES</code> if the brand identifier is enabled; <code>NO</code> otherwise
 */
- (BOOL)isBrandEnabled;

/**
 Enable motion activity for location marketing SDK
 
 @discussion Motion activity feature only works on iPhone 5s and later or iPad 2 and later, it's disabled by default.
 */
- (void)enableMotionActivity;

/**
 Starts the service.
 
 @discussion Turns on the SDK and puts it into a ready state to begin device registration and start location marketing services. This call has no effect if this service has previously been started.
 </p>
 */
- (void)start;

/**
 Stops the location marketing service.
 
 @discussion Turns off the SDK and stops location services. This call has no effect if this service has previously been stopped.
 */
- (void)stop;

/**
 Registers the {@link ILPLocalNotificationListener local notification listener} associated with the location marketing service.

 @param listener the {@link ILPLocalNotificationListener local notification listener}
 */
- (void)setLocalNotificationListener:(id<ILPLocalNotificationListener>)listener;

@end

#define ComDigbyLocalpointSdkCoreILPLocalpointService ILPLocalpointService
