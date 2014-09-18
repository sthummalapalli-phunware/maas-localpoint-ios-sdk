//
//  AttributeViewController.h
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 9/4/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TmpAttributeManager2.h"

@interface AttributeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,
UITextFieldDelegate, TmpAttributesRetrievalListener> {
    __weak IBOutlet UITextField *tfAttrName;
    __weak IBOutlet UITextField *tfAttrValue;
    __weak IBOutlet UITextView *tvResult;
    
    __weak IBOutlet UISegmentedControl *scAttrType;
    __weak IBOutlet UITableView *tblvAttributes;
}

- (IBAction)onClickAddUpdateButton:(id)sender;
- (IBAction)onClickDeleteButton:(id)sender;

- (IBAction)onClickSendButton:(id)sender;
- (IBAction)onClickGetButton:(id)sender;

@end
