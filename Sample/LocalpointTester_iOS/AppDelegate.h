//
//  AppDelegate.h
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/19/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Localpoint/Localpoint.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate, LPLoggingDelegate, LPLoggingDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (retain,strong) LPLocalpointService *lpService;

@end
