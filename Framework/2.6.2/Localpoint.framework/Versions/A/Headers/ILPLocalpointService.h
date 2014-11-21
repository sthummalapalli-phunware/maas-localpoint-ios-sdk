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
 A Localpoint service is the entry point for applications to Localpoint functionality.

 @version 2.6.0
 @since 1.0.0
 */
@protocol ILPLocalpointService < NSObject >

/**
 Returns the {@link ILPDevice device} associated with the Localpoint service.

 @discussion This method should never return <code>nil</code>.

 @return the {@link ILPDevice device} associated with the Localpoint service
 */
- (id<ILPDevice>)getDevice;

/**
 Returns the {@link ILPUser user} of the Localpoint service.

 @discussion This method should never return <code>nil</code>.

 @return the {@link ILPUser user} of the Localpoint service
 */
- (id<ILPUser>)getUser;

/**
 Returns the {@link ILPLocationProvider location provider} associated with the Localpoint service.
 
 @discussion This method should never return <code>nil</code>.

 @return the {@link ILPLocationProvider location provider} associated with the Localpoint service
 */
- (id<ILPLocationProvider>)getLocationProvider;

/**
 Returns the {@link ILPMessageProvider message provider} associated with the Localpoint service.

 @discussion This method should never return <code>nil</code>.

 @return the {@link ILPMessageProvider message provider} associated with the Localpoint service
 */
- (id<ILPMessageProvider>)getMessageProvider;

/**
 Returns the version for the Localpoint SDK.

 @discussion This method should never return <code>nil</code>.

 @return the version for the Localpoint SDK
 */
- (id<ILPVersion>)getSDKVersion;

/**
 Indicates whether the brand identifier used by this service is enabled.

 @return <code>YES</code> if the brand identifier is enabled; <code>NO</code> otherwise
 */
- (BOOL)isBrandEnabled;

/**
 Enable motion activity for Localpoint SDK
 
 @discussion Motion activity feature only works on iPhone 5s and later or iPad 2 and later, it's disabled by default.
 */
- (void)enableMotionActivity;

/**
 Starts this service.
 
 @discussion Turns on the SDK and puts it into a ready state to begin device registration and start location services. This call has no effect if this service has previously been started.
 </p>
 */
- (void)start;

/**
 Stops the Localpoint service.
 
 @discussion Turns off the SDK and stops location services. This call has no effect if this service has previously been stopped.
 */
- (void)stop;

/**
 Registers the {@link ILPLocalNotificationListener local notification listener} associated with the Localpoint service.

 @param listener the {@link ILPLocalNotificationListener local notification listener}
 */
- (void)setLocalNotificationListener:(id<ILPLocalNotificationListener>)listener;

@end

#define ComDigbyLocalpointSdkCoreILPLocalpointService ILPLocalpointService
