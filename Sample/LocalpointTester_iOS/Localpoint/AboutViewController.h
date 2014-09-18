//
//  AboutViewController.h
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/21/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController
@property(nonatomic, weak) IBOutlet UILabel *appVersion;
@property(nonatomic, weak) IBOutlet UILabel *sdkVersion;
@property(nonatomic, weak) IBOutlet UITextField *deviceId;
@end
