//
//  Localpoint.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Localpoint/LPLocalpointService.h>
#import <Localpoint/ILPAttributeListener.h>
#import <Localpoint/ILPAttributeManager.h>
#import <Localpoint/ILPAttributeValue.h>
#import <Localpoint/ILPDevice.h>
#import <Localpoint/ILPFilter.h>
#import <Localpoint/ILPGeopoint.h>
#import <Localpoint/ILPID.h>
#import <Localpoint/ILPLocalNotification.h>
#import <Localpoint/ILPLocalNotificationListener.h>
#import <Localpoint/ILPLocation.h>
#import <Localpoint/ILPLocationFilterFactory.h>
#import <Localpoint/ILPLocationListener.h>
#import <Localpoint/ILPLocationOrderingFactory.h>
#import <Localpoint/ILPLocationProvider.h>
#import <Localpoint/ILPMessage.h>
#import <Localpoint/ILPMessageFilterFactory.h>
#import <Localpoint/ILPMessageListener.h>
#import <Localpoint/ILPMessageOrderingFactory.h>
#import <Localpoint/ILPMessageProvider.h>
#import <Localpoint/ILPOrdering.h>
#import <Localpoint/ILPTag.h>
#import <Localpoint/ILPUser.h>
#import <Localpoint/ILPVersion.h>
#import <Localpoint/ILPRemoteNotificationListener.h>
#import <Localpoint/ILPEventHandler.h>
#import <Localpoint/LPEventHandler.h>

/**
 Location marketing framework container
 
 @version 2.6.0
 @since 2.6.0
 */
@interface Localpoint : NSObject

/**
 Returns the name of the SDK, it's `PWLocalpoint`.
 */
+ (NSString *)serviceName;


@end
