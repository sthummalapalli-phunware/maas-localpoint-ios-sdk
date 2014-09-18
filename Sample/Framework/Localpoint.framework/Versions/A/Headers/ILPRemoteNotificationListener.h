//
//  ILPRemoteNotificationListener.h
//  Localpoint
//
//  Created by Digby on 2/1/13.
//
//

#import <Foundation/Foundation.h>

@protocol ILPRemoteNotificationListener < NSObject >

- (void) didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void) didReceiveRemoteNotification:(NSDictionary *)userInfo;

@end
