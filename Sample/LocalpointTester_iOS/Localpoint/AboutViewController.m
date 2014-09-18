//
//  AboutViewController.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/21/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize appVersion;
@synthesize sdkVersion;
@synthesize deviceId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    LPLocalpointService *lpService = [LPLocalpointService instance];
    id<ILPVersion> sdkVersionObj = [lpService getSDKVersion];
    sdkVersion.text = [sdkVersionObj description];
    appVersion.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
    id<ILPID> lpDeviceId = [[lpService getDevice] getID];
    // TODO Add this back in...it currently crashes the app
    deviceId.text = [lpDeviceId getValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == deviceId) {
        [textField resignFirstResponder];
    }
    return NO;
}

@end
