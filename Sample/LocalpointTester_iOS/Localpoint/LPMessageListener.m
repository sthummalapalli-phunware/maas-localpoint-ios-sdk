//
//  LPMessageListener.m
//  LPTester
//
//  Created by Jason Schmitt on 2/18/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "LPMessageListener.h"
#import "DetailsViewController.h"
#import "iToast.h"
#import "BadgeManager.h"
#import "LPLoggingManager.h"

@implementation LPMessageListener

- (void)onAdd:(id<ILPMessage>)message {
    NSString *msg = [NSString stringWithFormat:@"Added message: %@", [message getTitle]];
    [LPLoggingManager logExternal:msg];
    [[[iToast makeText:msg] setDuration:iToastDurationLong] show];
    [BadgeManager refreshBadgeCount];
    // TODO Navigate to promotion
    [self refreshDetailsView];
}

- (void)onModify:(id<ILPMessage>)message {
    NSString *msg = [NSString stringWithFormat:@"Modified message: %@", [message getTitle]];
    [LPLoggingManager logExternal:msg];
    [[[iToast makeText:msg] setDuration:iToastDurationLong] show];
    [BadgeManager refreshBadgeCount];
    [self refreshDetailsView];
}

- (void)onDelete:(id<ILPID>)ID {
    NSString *msg = [NSString stringWithFormat:@"Removed message ID %@", [ID getValue]];
    [LPLoggingManager logExternal:msg];
    [[[iToast makeText:msg] setDuration:iToastDurationLong] show];
    [BadgeManager refreshBadgeCount];
    [self refreshDetailsView];
}

- (void)refreshDetailsView {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    DetailsViewController *controller = (DetailsViewController*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"detailsView"];
    [controller updateOffersCount];
}

@end
