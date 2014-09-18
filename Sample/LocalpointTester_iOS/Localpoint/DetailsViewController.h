//
//  DetailsViewController.h
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/21/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController
@property(nonatomic, weak) IBOutlet UITextField *brandTextField;
@property(nonatomic, weak) IBOutlet UITextField *appIdTextField;
@property(nonatomic, weak) IBOutlet UITextField *serverTextField;
@property(nonatomic, weak) IBOutlet UITextField *searchRadius;
@property(nonatomic, weak) IBOutlet UITextField *numberLocations;
@property(nonatomic, weak) IBOutlet UITextField *numberLocationsIn;
@property(nonatomic, weak) IBOutlet UITextField *checkInLocations;
@property(nonatomic, weak) IBOutlet UITextField *numberOffers;

- (void)updateLocationsCount;
- (void)updateLocationsInCount;
- (void)updateCheckInLocationsCount;
- (void)updateOffersCount;

@end
