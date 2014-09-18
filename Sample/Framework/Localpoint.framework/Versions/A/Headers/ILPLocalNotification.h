//
//  ILPLocalNotification.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import "ILPMessage.h"

/**
 A local notification is a communication (generally marketing related) sent from the server.

 @version 2.6.0
 @since 2.6.0
 */
@protocol ILPLocalNotification < ILPMessage, NSObject >

/**
 Returns the title of this local notification.
 
 @discussion This method should never return <code>nil</code>.
 
 @return the title of this local notification
 */
- (NSString *)getNotificationTitle;

/**
 Returns the message of this local notification.
 
 @discussion This method should never return <code>nil</code>.
 
 @return the message of this local notification
 */
- (NSString *)getNotificationMessage;

/**
 Returns the campaign type of this local notification.
 
 @discussion This method should never return <code>nil</code>.
 
 @return the campaign type of this local notification
 */
- (NSString *)getCampaignType;

/**
 Sets the title of this local notification
 
 @param title The customized title for this local notification.
 */
- (void)setNotificationTitle:(NSString *)title;

/**
 Sets the message of this local notification
 
 @param message The customized message for this local notification.
 */
- (void)setNotificationMessage:(NSString *)message;

/**
 Sets the campaign title of this local notification
 
 @param campaignTitle The customized campaign title for this local notification.
 */
- (void)setCampaignTitle:(NSString *)campaignTitle;

/**
 Sets the campaign body of this local notification
 
 @param campaignBody The customized campaign body for this local notification.
 */
- (void)setCampaignBody:(NSString *)campaignBody;

@end

#define ComDigbyLocalpointSdkCoreILPLocalNotification ILPLocalNotification
