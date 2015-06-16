//
//  IdentifierViewController.m
//  LocalpointTester_iOS
//
//  Created by Quan Feng on 9/16/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "IdentifierViewController.h"
#import "LPLoggingManager.h"
#import "MyLPConfiguration.h"
#import "TmpAttributeManager2.h"

@interface IdentifierViewController ()

@end

@implementation IdentifierViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    id1ValueTextField = nil;
    resultTextView = nil;
    [super viewDidUnload];
}

- (IBAction) onClickSendButton:(id)sender {
    NSString *id1Value = [id1ValueTextField text];
    
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
    [attrs setObject:id1Value forKey:@"ID1"];
    
    id<ILPAttributeManager> attrMgr = [MyLPConfiguration getAttributeManager:resultTextView];
    [attrMgr updateUserAttributes:attrs];
}

- (IBAction) onClickGetButton:(id)sender {
    NSLog(@"Clicked Get ID1 button.");
    id<ILPAttributeManager> attrMgr = [MyLPConfiguration getAttributeManager:resultTextView];
    [attrMgr getUserAttributes:^(NSDictionary *attributes, NSError *error) {
        resultTextView.text = [attributes description];
    }];
}

- (BOOL) textFieldShouldReturn:( UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (void)onGetSuccess:(NSString *)result {
    NSString *infoMsg = [NSString stringWithFormat:@"Got attributes successfully: %@", result];
    [resultTextView performSelectorOnMainThread:@selector(setText:) withObject:infoMsg waitUntilDone:NO];
    [LPLoggingManager logExternal:infoMsg];
}

- (void)onGetFailure:(NSError *)error {
    NSString *errMsg = [NSString stringWithFormat:@"Failed to get attributes. Error: %d. %@",
                        [error code], [error description]];
    [resultTextView performSelectorOnMainThread:@selector(setText:) withObject:errMsg waitUntilDone:NO];
    [LPLoggingManager logExternal:errMsg];
}

@end
