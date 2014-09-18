//
//  LPInternalLoggingDelegate.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 7/5/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import "LPInternalLoggingDelegate.h"

@implementation LPInternalLoggingDelegate

- (void) log:(NSString *)msg {
    NSLog(@"LP_SDK (internal) ::: %@", msg);
}

@end
