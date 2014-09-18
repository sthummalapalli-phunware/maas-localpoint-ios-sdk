//
//  Localpoint.h
//  Localpoint
//
//  Created by Xiangwei Wang on 9/16/14.
//
//

#import <Foundation/Foundation.h>
// Localpoint
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

@interface Localpoint : NSObject

/**
 Returns the name of the SDK, `PWLocalpoint`.
 */
+ (NSString *)serviceName;


@end
