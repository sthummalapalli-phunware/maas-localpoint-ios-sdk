//
//  UIAlertView+LPTAlertView.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 11/25/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import "UIAlertView+LPTAlertView.h"
#import <objc/runtime.h>

NSString * const kLPMessageIdKey = @"kLPMessageIdKey";

@implementation UIAlertView (LPTAlertView)

- (void)setMessageId:(NSString *)messageId {
    objc_setAssociatedObject(self, &kLPMessageIdKey, messageId, OBJC_ASSOCIATION_COPY);
}

- (NSString *)messageId {
    return objc_getAssociatedObject(self, &kLPMessageIdKey);
}

@end
