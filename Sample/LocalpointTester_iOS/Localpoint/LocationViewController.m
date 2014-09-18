//
//  LocationViewController.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 3/12/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "LocationViewController.h"
#import "Util.h"
#import "iToast.h"

@interface LocationViewController ()

@end

@implementation LocationViewController
@synthesize confirmationView;
@synthesize downloadingView;
@synthesize location;
@synthesize tagsTableView;
@synthesize locationCode;
@synthesize deviceInLabel;
@synthesize checkinButton;
@synthesize description;

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
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    locationCode.text = [location getCode];
    if ([location isDeviceIn])
        deviceInLabel.text = @"Device IS in this location";
    else
        deviceInLabel.text = @"Device is NOT in this location";
    
    // Update check in button text if location does not allow it but let button still try to allow for testing
    id<ILPFilter> ci = [[[[LPLocalpointService instance] getLocationProvider] getFilterFactory] getAllowsCheckInFilter];
    if ([ci accept:location]) {
        [checkinButton setTitle:@"Check In" forState:UIControlStateNormal];
    } else {
        [checkinButton setTitle:@"Check In (fail)" forState:UIControlStateNormal];
    }
    description.text = [location getDescription];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[location getTags] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TagNameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *tagsArray = [[location getTags] allObjects];
    id<ILPTag> tag = [tagsArray objectAtIndex:[indexPath row]];
    cell.textLabel.text = [tag getName];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Tags";
    return @"unexpected section";
}

#pragma mark Check In button
- (IBAction)checkInToLocation:(id)sender {
    NSLog(@"Check in to location %@ clicked.", [location getName]);
    
    self.downloadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.downloadingView.backgroundColor = [UIColor clearColor];
    
    UIView*backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    backgroundView.backgroundColor = [Util colorWithHexString:@"1d3b84"];
    backgroundView.alpha = 0.8;
    [self.downloadingView addSubview:backgroundView];
    
    UILabel* downloadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 50)];
    downloadingLabel.backgroundColor = [UIColor clearColor];
    downloadingLabel.text = @"One moment while we download offers for this location";
    downloadingLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    downloadingLabel.textColor = [UIColor whiteColor];
    downloadingLabel.numberOfLines = 0;
    downloadingLabel.textAlignment = NSTextAlignmentCenter;
    [downloadingView addSubview:downloadingLabel];
    
    UIActivityIndicatorView *tempSpinner = [[UIActivityIndicatorView alloc]  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    tempSpinner.frame = CGRectMake(125, 100, 80, 80);
    [self.downloadingView addSubview:tempSpinner];
    [tempSpinner startAnimating];
    
    [self.view addSubview:self.downloadingView];
    
    [self performSelector:@selector(doCheckInWithLocation:) withObject:location afterDelay:0];
} 

- (void)doCheckInWithLocation:(id<ILPLocation>)loc {
    [loc checkIn];
    [self resetViews];
}

- (void)resetViews {
    [self.downloadingView removeFromSuperview];
    self.downloadingView = nil;
    [self.tagsTableView reloadData];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
