//
//  MessagesViewController.h
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/19/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromotionViewController.h"

@interface MessagesViewController : UITableViewController
{
    NSArray *messages;
    NSArray *validMessages;
    NSArray *expiredMessages;
    PromotionViewController * promoViewer;
    
}

@property (nonatomic, retain) NSArray *messages;
@property (nonatomic, retain) NSArray *validMessages;
@property (nonatomic, retain) NSArray *expiredMessages;
@property (nonatomic, retain) PromotionViewController *promoViewer;

@end
