//
//  MyLPConfiguration.h
//  LocalpointTester_iOS
//
//  Created by Quan Feng on 9/17/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TmpAttributeManager2.h"

@interface MyLPConfiguration : NSObject

+ (BOOL) useMyConfig;

+ (NSString *) deviceId;
+ (NSString *) lpAppId;
+ (NSString *) brandCode;
+ (NSString *) lpServerRootUrl;

+ (id<ILPAttributeManager>) getAttributeManager:(UITextView *)resultTextView;

+ (TmpAttributeManager2 *) getTmpAttributeManager2:(UITextView *)resultTextView;

@end
