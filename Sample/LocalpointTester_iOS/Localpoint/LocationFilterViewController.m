//
//  LocationFilterViewController.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 4/2/14.
//  Copyright (c) 2014 Jason Schmitt. All rights reserved.
//

#import "LocationFilterViewController.h"
#import "LocationFilters.h"

@interface LocationFilterViewController ()

@end

@implementation LocationFilterViewController

@synthesize allowsCheckIn;
@synthesize deviceIsIn;

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
    [self resetSwitches];
}

- (void)resetSwitches {
    [allowsCheckIn setOn:[LocationFilters getAllowsCheckinFilterState] animated:YES];
    [deviceIsIn setOn:[LocationFilters getDeviceIsInFilterState] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAllowsCheckinChange:(id)sender {
    UISwitch *ctrl = (UISwitch *)sender;
    [LocationFilters setAllowsCheckinFilterState:[ctrl isOn]];
}

- (IBAction)onDeviceIsInChange:(id)sender {
    UISwitch *ctrl = (UISwitch *)sender;
    [LocationFilters setDeviceIsInFilterState:[ctrl isOn]];
}

- (IBAction)onResetClicked:(id)sender {
    [LocationFilters resetStates];
    [self resetSwitches];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
