//
//  ILPLocalNotificationListener.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPLocalNotification;

/**
 A local notification listener receives updates concerning {@link ILPLocalNotification}.

 @version 2.6.0
 @since 2.6.0
 */
@protocol ILPLocalNotificationListener < NSObject >
@optional
/**
 Informs this listener that a new {@link ILPLocalNotification notification} has been received from server. Returns a boolean value that indicates whether this listener will override local notification.
 
 @discussion The updated campaign data in {@link ILPLocalNotification notification} will be stored the into local storage, not the original one.

 @param notification The local notification data received from server.
 @return {@code true} the application will fire local notification,
         {@code false} the SDK will fire the local notification, use the {@link ILPLocalNotification notification} from {@link ILPLocalNotificationListener#onOverrideLocalNotification(ILPLocalNotification)}
 */
- (BOOL)onOverrideLocalNotification:(id<ILPLocalNotification>)notification;

@end

#define ComDigbyLocalpointSdkCoreILPLocalNotificationListener ILPLocalNotificationListener
