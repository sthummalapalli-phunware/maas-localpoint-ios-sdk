//
//  CheckInViewController.h
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/19/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationCheckInCell.h"

@interface CheckInViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSArray *locations;
}

@property (nonatomic,retain) NSArray *locations;
@property (strong,nonatomic) NSMutableArray *filteredLocations;
@property IBOutlet UISearchBar *locationSearchBar;

//- (IBAction)onClickFilterButton:(id)sender;

@end
