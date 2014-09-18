//
//  BadgeManager.m
//  LocalpointTester_iOS
//
//  Created by Dev on 3/26/14.
//  Copyright (c) 2014 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "BadgeManager.h"
#import "UnreadMessagesFilter.h"
#import "LPLoggingManager.h"

@implementation BadgeManager

+ (int)badgeCount {
    id<ILPMessageProvider> prov = [[LPLocalpointService instance] getMessageProvider];
    UnreadMessagesFilter *filter = [[UnreadMessagesFilter alloc] init];
    NSArray *msgs = [prov getMessages:filter withOrdering:nil];
    return [msgs count];
}

+ (void)refreshBadgeCount {
    int count = [self badgeCount];
    [LPLoggingManager logExternal:@"Setting badge count to %d", count];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}

@end
