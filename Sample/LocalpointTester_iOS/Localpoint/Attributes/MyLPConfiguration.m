//
//  MyLPConfiguration.m
//  LocalpointTester_iOS
//
//  Created by Quan Feng on 9/17/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>

#import "LPConfiguration.h"
#import "LPAuthenticationHelper.h"
#import "LPAttributeManager.h"
#import "TmpAttributeManager2.h"

#import "LPAttributeListener.h"
#import "MyLPConfiguration.h"


//static NSString * const DEVICE_ID   = @"6c2cb3dc65e54ac9";
//This is a valid deviceId in playground on console.dev.digby.com
static NSString * const DEVICE_ID   = @"0159ed5bd6deb7be4b6e8d496d68c56c07aec73d";

static NSString * const APP_ID      = @"a4a94fe7-c25f-442c-a761-64d06595d498";
static NSString * const BRAND_CODE  = @"playground";
//static NSString * const LP_ROOT_URL = @"http://192.168.10.72:9091";
static NSString * const LP_ROOT_URL = @"https://playground.api.dev.digby.com";

@implementation MyLPConfiguration

//Remember to change this to false before checking code into GitHub
+ (BOOL) useMyConfig {
    return false;
}

+ (NSString *) deviceId {
    return DEVICE_ID;
}

+ (NSString *) lpAppId {
    return APP_ID;
}

+ (NSString *) brandCode {
    return BRAND_CODE;
}

+ (NSString *) lpServerRootUrl {
    return LP_ROOT_URL;
}

+ (id<ILPAttributeManager>) getAttributeManager:(UITextView *)resultTextView {
    LPLocalpointService *lpService = [LPLocalpointService instance];
    
    LPAttributeManager *attrMgr = nil;
    if ([MyLPConfiguration useMyConfig]) {
        LPAuthenticationHelper *authHelper =
            [[LPAuthenticationHelper alloc] initWithAppId:APP_ID brandCode:BRAND_CODE];
        attrMgr = [[LPAttributeManager alloc] initWithDeviceId:DEVICE_ID localpointServerRootURL:LP_ROOT_URL];
        [attrMgr setAuthenticationHelper:authHelper];
    }
    else
        attrMgr = [[lpService getUser] getAttributeManager];
    
    LPAttributeListener *listener = [[LPAttributeListener alloc] initWithTextView:resultTextView];
    [attrMgr addListener:listener];
    
    return attrMgr;
}

+ (TmpAttributeManager2 *) getTmpAttributeManager2:(UITextView *)resultTextView {
    TmpAttributeManager2 *attrMgr2 = nil;
    
    NSString *appId = APP_ID;
    NSString *brand = BRAND_CODE;
    NSString *deviceId = DEVICE_ID;
    NSString *lpRootUrl = LP_ROOT_URL;
    if (![MyLPConfiguration useMyConfig]) {
        LPConfiguration *cfg = [LPConfiguration instance];
        appId = cfg.appID;
        brand = cfg.brand;
        lpRootUrl = cfg.localpointServerRootURL;
        
        LPLocalpointService *lpService = [LPLocalpointService instance];
        deviceId = [[[lpService getDevice] getID] getValue];
    }
   
    LPAuthenticationHelper *authHelper = [[LPAuthenticationHelper alloc] initWithAppId:appId brandCode:brand];
    attrMgr2 = [[TmpAttributeManager2 alloc] initWithDeviceId:deviceId localpointServerRootURL:lpRootUrl];
    [attrMgr2 setAuthenticationHelper:authHelper];
        
    return attrMgr2;
}

@end
