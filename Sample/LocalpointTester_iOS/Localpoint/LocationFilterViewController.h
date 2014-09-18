//
//  LocationFilterViewController.h
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 4/2/14.
//  Copyright (c) 2014 Jason Schmitt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationFilterViewController : UIViewController

@property IBOutlet UISwitch *allowsCheckIn;
@property IBOutlet UISwitch *deviceIsIn;

- (IBAction)onAllowsCheckinChange:(id)sender;
- (IBAction)onDeviceIsInChange:(id)sender;
- (IBAction)onResetClicked:(id)sender;

@end
