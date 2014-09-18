//
//  DetailsViewController.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/21/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "DetailsViewController.h"
#import "LPConfiguration.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize brandTextField;
@synthesize appIdTextField;
@synthesize serverTextField;
@synthesize searchRadius;
@synthesize numberLocations;
@synthesize numberLocationsIn;
@synthesize checkInLocations;
@synthesize numberOffers;

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
    LPConfiguration *cfg = [LPConfiguration instance];
    brandTextField.text = cfg.brand;
    appIdTextField.text = cfg.appID;
    serverTextField.text = cfg.server;
    searchRadius.text = [NSString stringWithFormat:@"%d", cfg.searchRadius];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateLocationsCount];
    [self updateCheckInLocationsCount];
    [self updateOffersCount];
    [self updateLocationsInCount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLocationsCount {
    LPLocalpointService *lpService = [LPLocalpointService instance];
    numberLocations.text = [NSString stringWithFormat:@"%d", [[[lpService getLocationProvider] getLocations] count]];
    // TODO Reload view here somehow. Tried several methods with no success
//    [self reloadInputViews];
//    [self.view setNeedsDisplay];
//    [self.view reloadInputViews];
}

- (void)updateLocationsInCount {
    id<ILPDevice> device = [[LPLocalpointService instance] getDevice];
    numberLocationsIn.text = [NSString stringWithFormat:@"%d", [[device getLocationsIn] count]];
    numberLocationsIn.textAlignment = NSTextAlignmentRight;
}

- (void)updateCheckInLocationsCount {
    LPLocalpointService *lpService = [LPLocalpointService instance];
    id<ILPFilter> allowsCheckIns = [[[lpService getLocationProvider] getFilterFactory] getAllowsCheckInFilter];
    NSUInteger checkInCount = [[lpService getLocationProvider] getLocations:allowsCheckIns withOrdering:nil].count;
    checkInLocations.text = [NSString stringWithFormat:@"%d", checkInCount];
}

- (void)updateOffersCount {
    LPLocalpointService *lpService = [LPLocalpointService instance];
    numberOffers.text = [NSString stringWithFormat:@"%d", [[[lpService getMessageProvider] getMessages] count]];
}

@end
