//
//  LPLocalNotificationListener.m
//  LocalpointTester_iOS
//
//  Created by Xiangwei Wang on 8/21/14.
//  Copyright (c) 2014 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "LPLocalNotificationListener.h"

@implementation LPLocalNotificationListener

-(BOOL)onOverrideLocalNotification:(id<ILPLocalNotification>)notification {
//    if ([[notification getCampaignType] isEqualToString:@"GEOFENCE_ENTRY"]) {
//        // Custom the Geofence entry message
//        // Custom the notification title, it will display in an alert of notification tree
//        [notification setNotificationTitle:@"Entry custom: notification title"];
//        
//        // Custom the notification message, it will display in an alert of notification tree
//        [notification setNotificationMessage:@"Entry custom: notification message"];
//        
//        // Custom the campaign title, it will display in your offer list
//        [notification setCampaignTitle:@"Entry custom: campaign title"];
//        
//        // Custom the campaign body, this is the offer detail
//        [notification setCampaignBody:@"Entry custom: campaign body"];
//    } else if ([[notification getCampaignType] isEqualToString:@"GEOFENCE_EXIT"]) {
//        // Custom the Geofence entry message
//        // Custom the notification title, it will display in an alert of notification tree
//        [notification setNotificationTitle:@"Exit custom: notification title"];
//        
//        // Custom the notification message, it will display in an alert of notification tree
//        [notification setNotificationMessage:@"Exit custom: notification message"];
//        
//        // Custom the campaign title, it will display in your offer list
//        [notification setCampaignTitle:@"Exit custom: campaign title"];
//        
//        // Custom the campaign body, this is the offer detail
//        [notification setCampaignBody:@"Exit custom: campaign body"];
//    } else if ([[notification getCampaignType] isEqualToString:@"CHECKIN"]) {
//        // Custom the Geofence entry message
//        // Custom the notification title, it will display in an alert of notification tree
//        [notification setNotificationTitle:@"Checkin custom: notification title"];
//        
//        // Custom the notification message, it will display in an alert of notification tree
//        [notification setNotificationMessage:@"Checkin custom: notification message"];
//        
//        // Custom the campaign title, it will display in your offer list
//        [notification setCampaignTitle:@"Checkin custom: campaign title"];
//        
//        // Custom the campaign body, this is the offer detail
//        [notification setCampaignBody:@"Checkin custom: campaign body"];
//    }
    // If return 'NO', SDK will send local notification base on this ILPLocalNotification object
    // If return 'YES', SDK will not send local notification, but will keep this ILPLocalNotification, you can get it through the APIs in message provider.
    return NO;
}

@end
