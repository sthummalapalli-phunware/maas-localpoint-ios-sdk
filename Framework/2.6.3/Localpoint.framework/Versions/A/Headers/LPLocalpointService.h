//
//  LPLocalpointService.h
//  Localpoint
//
//  Created by Digby on 1/21/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#import <Localpoint/ILPLocalpointService.h>
#import <Localpoint/ILPRemoteNotificationListener.h>

//#import "ILPLocalpointService.h"
//#import "ILPRemoteNotificationListener.h"

@protocol LPLoggingDelegate;

@interface LPLocalpointService : NSObject <ILPLocalpointService, ILPRemoteNotificationListener> {

    __unsafe_unretained id<LPLoggingDelegate> logDelegate;
    
}

/*!
 *
 *   @discussion
 *     Debugging statements, useful for testing
 */
@property (assign) id<LPLoggingDelegate> logDelegate;

+ (LPLocalpointService *) instance;

- (id<ILPLocalNotificationListener>)getLocalNotificationProvider;

- (void) appDidFinishLaunchingWithOptions: (NSDictionary *) launchOptions;

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end

/*!
 *
 *  @discussion
 *    Select useful logging messages will be sent to this delegate method.
 *  @availability Available in Localpoint 2.2.1
 */
@protocol LPLoggingDelegate <NSObject>
- (void)log:(NSString*)msg;
@end
