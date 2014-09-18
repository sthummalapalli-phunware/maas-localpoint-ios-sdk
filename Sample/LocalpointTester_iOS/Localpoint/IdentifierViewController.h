//
//  IdentifierViewController.h
//  LocalpointTester_iOS
//
//  Created by Quan Feng on 9/16/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TmpAttributeManager2.h"

@interface IdentifierViewController : UIViewController <UITextFieldDelegate, TmpAttributesRetrievalListener> {

    __weak IBOutlet UITextField *id1ValueTextField;
    __weak IBOutlet UITextView *resultTextView;
}

- (IBAction) onClickSendButton:(id)sender;
- (IBAction) onClickGetButton:(id)sender;

- (IBAction)backgroundTapped:(id)sender;

@end
