//
//  LPLocationListener.m
//  LPTester
//
//  Created by Jason Schmitt on 2/15/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "LPLocationListener.h"
#import "DetailsViewController.h"
#import "iToast.h"

@implementation LPLocationListener

- (void)onAdd:(id<ILPLocation>)location {
    NSLog(@"%@ added to locations", [location getName]);
    [self refreshDetailsView];
}

- (void)onModify:(id<ILPLocation>)location {
    NSLog(@"%@ modified in locations", [location getName]);
    [self refreshDetailsView];
}

- (void)onDelete:(id<ILPID>)ID {
    NSLog(@"Deleted location with ID: %@", [ID getValue]);
    [self refreshDetailsView];
}

- (void)onEntry:(id<ILPLocation>)location {
    NSLog(@"Entered location: %@", [location getName]);
    [[[iToast makeText:[NSString stringWithFormat:@"Entered: %@", [location getName]]] setDuration:iToastDurationLong] show];
    
    NSString *msg = [NSString stringWithFormat:@"You have entered %@", [location getName]];
    [self scheduleLocalNotificationWithMessage:msg];
}

- (void)onExit:(id<ILPLocation>)location {
    NSLog(@"Exited location: %@", [location getName]);
    [[[iToast makeText:[NSString stringWithFormat:@"Exited: %@", [location getName]]] setDuration:iToastDurationLong] show];
    NSString *msg = [NSString stringWithFormat:@"You have exited %@", [location getName]];
    [self scheduleLocalNotificationWithMessage:msg];
}

- (void) scheduleLocalNotificationWithMessage:(NSString *)msg {
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    notif.alertBody = msg;
    notif.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
}

- (void)onCheckInFailure:(id<ILPLocation>)location withError:(NSError *)error {
    NSLog(@"Failed to check into location: %@", [location getName]);
    [[[iToast makeText:[NSString stringWithFormat:@"Check in failed: %@", [location getName]]] setDuration:iToastDurationLong] show];
}

- (void)onCheckInSuccess:(id<ILPLocation>)location {
    NSLog(@"Checked in to location: %@", [location getName]);
    [[[iToast makeText:[NSString stringWithFormat:@"Checked in to: %@", [location getName]]] setDuration:iToastDurationLong] show];
}

- (void)refreshDetailsView {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    DetailsViewController *controller = (DetailsViewController*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"detailsView"];
    [controller updateLocationsCount];
}

@end
