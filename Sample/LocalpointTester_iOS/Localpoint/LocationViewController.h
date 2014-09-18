//
//  LocationViewController.h
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 3/12/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *tagsTableView;
    id<ILPLocation> location;
    UIView* downloadingView;
    UIView* confirmationView;
}

@property (nonatomic,retain) UIView* downloadingView;
@property (nonatomic,retain) UIView* confirmationView;
@property(nonatomic, weak) IBOutlet UITextField *locationCode;
@property (nonatomic, weak) IBOutlet UILabel *deviceInLabel;
@property (nonatomic, weak) IBOutlet UILabel *description;
@property (nonatomic,retain) IBOutlet UITableView *tagsTableView;
@property IBOutlet UIButton *checkinButton;
@property (nonatomic,retain) id<ILPLocation> location;

- (IBAction)checkInToLocation:(id)sender;
@end
