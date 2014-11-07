//
//  AppDelegate.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/19/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//
#import <Crashlytics/Crashlytics.h>
#import <Localpoint/Localpoint.h>
#import "AppDelegate.h"
#import "LPLocationListener.h"
#import "LPMessageListener.h"
#import "MessagesViewController.h"
#import "LPLocalNotificationListener.h"

#import "LPLoggingManager.h"
#import "LPInternalLoggingDelegate.h"
#import "CLRegion+LPRegion.h"

#import "LPMessageID.h"
#import "UIAlertView+LPTAlertView.h"
#import "BadgeManager.h"

/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@implementation AppDelegate {
@private
    LPInternalLoggingDelegate *internalLogger;
    UIActivityIndicatorView *activityIndicator;
    UIAlertView *localNotifAlertView;
}

@synthesize lpService;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"App did finish launching with options.");
    [LPLoggingManager logExternal:@"App did finish launching with options."];
    // Override point for customization after application launch.
    
    [Crashlytics startWithAPIKey:@"b8127086af392cb1b73dc00a7387bb7a0856138f"];
    
    // INTERNAL USE ONLY
    internalLogger = [[LPInternalLoggingDelegate alloc] init];
    [LPLoggingManager instance].internalLogger = internalLogger;
    
    //Create an instance of LPLocalpointService
    lpService = [LPLocalpointService instance];
    lpService.logDelegate = self;
    [[lpService getLocationProvider] addListener:[[LPLocationListener alloc] init]];
    [[lpService getMessageProvider] addListener:[[LPMessageListener alloc] init]];
    [lpService setLocalNotificationListener:[[LPLocalNotificationListener alloc] init]];
    
    //Start the service
    [lpService start];
    
    // Register device with APNS for push notifications
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    // Always inform Localpoint that the app launched. Let the SDK figure out if anything needs to be done.
    [lpService appDidFinishLaunchingWithOptions:launchOptions];
    
    // Did we launch based on tapping remote or local notification?
    if (launchOptions) {
        if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]) {
            NSString *msgId = [[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] objectForKey:@"messageId"];
            [self showIndicatorAndRedirect:msgId];
        } else if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey]) {
            UILocalNotification *notif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
            [self showIndicatorAndRedirect:[notif.userInfo objectForKey:@"messageId"]];
        }
    }
    
    [BadgeManager refreshBadgeCount];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [LPLoggingManager logExternal:@"Application will resign active."];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [LPLoggingManager logExternal:@"Application did enter background."];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self logRegionsMonitored];
    
    NSLog(@"Application will enter foreground.");
    [LPLoggingManager logExternal:@"Application will enter foreground."];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"Application did become active.");
    [LPLoggingManager logExternal:@"Application did become active."];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // System gives about 5 seconds to complete this task
    //    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        [LPLoggingManager logExternal:@"Application will terminate on iOS 7 so stopping Localpoint."];
        NSLog(@"Application will terminate on iOS 7 so stopping Localpoint.");
        [lpService stop];
    }
    [LPLoggingManager logExternal:@"Application was terminated."];
}

#pragma mark - Handling Local Notifications

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notif {
    NSLog(@"Received local notification. Displaying as alert");
    
    if([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive){
        // Replace %% with % in notif.alertBody if exists
        NSString *notificationMessage = [notif.alertBody stringByReplacingOccurrencesOfString:@"%%"
                                                                                   withString:@"%"];
        localNotifAlertView = [[UIAlertView alloc] initWithTitle:nil
                                                         message:notificationMessage
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:nil];
        [localNotifAlertView setMessageId:[notif.userInfo objectForKey:@"messageId"]];
        if ([notif.userInfo objectForKey:@"messageId"])
            [localNotifAlertView addButtonWithTitle:@"View"];
        else
            [localNotifAlertView addButtonWithTitle:@"Wallet"];     // Tester app local notifs will display this...can be changed
        [localNotifAlertView show];
    } else {
        [self showIndicatorAndRedirect: [notif.userInfo objectForKey:@"messageId"]];
    }
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView == localNotifAlertView && buttonIndex != alertView.cancelButtonIndex)
        [self showIndicatorAndRedirect: [alertView messageId]];
}

#pragma mark - Handling Remote Notifications

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //Pass the deviceToken to Localpoint SDK.
    
    NSLog(@"token token come out: %@", deviceToken);
    
    [lpService didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"I get something from the remote Notifiation %@", userInfo);
    
    //Pass the notification to Localpoint SDK.
    [lpService didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Your error handling code goes here
    NSLog(@"Failed to get token, error: %@", error);
}

#pragma mark - Handling Background Fetch
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    [lpService application:application performFetchWithCompletionHandler:completionHandler];
}

#pragma mark - LPLoggingDelegate
- (void)logLP:(NSString *)msg {
    NSLog(@"LP_SDK ::: %@", msg);
}

#pragma mark - DigbyLoggingDelegate -- INTERNAL USE ONLY
- (void)log:(NSString*)msg {
    NSLog(@"LP_SDK (internal) ::: %@", msg);
}

- (void) logRegionsMonitored {
    // Get location manager from LPRegionMonitor
    CLLocationManager *iMgr = [[CLLocationManager alloc] init];
    NSSet *regions = iMgr.monitoredRegions;
    [LPLoggingManager logInternal:@"Monitoring %lu regions:", [regions count]];
    for (CLRegion *r in regions) {
        [LPLoggingManager logInternal:[r details]];
    }
}

#pragma mark - Wallet/Offer redirect helper methods

/**
 *  We will wait a bit just in case an offer has not yet arrived. Show an activity indicator during delay.
 */
- (void) showIndicatorAndRedirect:(NSString *) messageId{
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = self.window.rootViewController.view.center;
    [self.window.rootViewController.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    // Delay added to support remote notifications and the delay it takes before the push callback loads the offer into the wallet
    if ([[lpService getMessageProvider] getMessage:[[LPMessageID alloc] initWithString:messageId]]) {
        // Opening message detail view directly
        [self redirectToPromotion:messageId];
    } else {
        // Opening message detail view until message body is completed loading from Localpoint server
        [self performSelector:@selector(redirectToPromotion:) withObject:messageId afterDelay:3.0f];
    }
}

/**
 * If the given messageId points to a message in the wallet, view the message. Otherwise, navigate to the wallet.
 */
- (void) redirectToPromotion:(NSString*) messageId{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    // Main tab bar
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    tabBarController.selectedIndex = 2; // Change to offers tab.
    
    id<ILPMessageProvider> mp = [[LPLocalpointService instance] getMessageProvider];
    id<ILPID> mId = [[LPMessageID alloc] initWithString:messageId];
    id<ILPMessage> message = [mp getMessage:mId];
    if (message) {
        [LPLoggingManager logExternal:@"Found promotion message: %@", [message getTitle]];

        PromotionViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"promotionControllerView"];
        [viewController setMessage:(message)];
        [(UINavigationController *)tabBarController.selectedViewController pushViewController:viewController animated:YES];
    }
    
    [activityIndicator stopAnimating];
}

@end
