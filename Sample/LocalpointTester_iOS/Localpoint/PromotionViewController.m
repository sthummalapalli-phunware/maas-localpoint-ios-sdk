//
//  PromotionViewController.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/21/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "PromotionViewController.h"
#import "MessagesViewController.h"
#import "BadgeManager.h"

@interface PromotionViewController () {

}

@end

@implementation PromotionViewController {
    @private
    NSArray *metadataKeys;
}

@synthesize message;
@synthesize messageBodyView;
@synthesize pickerMetadataKey;
@synthesize labelMetadataKey;

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
    
    self.navigationController.navigationBar.hidden = NO;
    
    metadataKeys = [[message getMetadata] allKeys];
    
    [self.view addSubview:self.messageBodyView];
    if (metadataKeys && [metadataKeys count] > 0) {
        [self.view addSubview:self.pickerMetadataKey];
        [self.view addSubview:self.labelMetadataKey];
    }
    
    NSString *msgBody = [message getBody];
    NSString *msgId = [NSString stringWithFormat:@"<HR>Message ID: %@", [[message getID] getValue] ];
    NSString *msgExpiry = [NSString stringWithFormat:@"<br>Expiration Date: %@", [message getExpirationDate]];
    NSString *msgMetadata = [NSString stringWithFormat:@"<br>Metadata: %@", [[message getMetadata] description] ];
    
    NSString *display = [NSString stringWithFormat:@"%@%@%@%@", msgBody, msgId, msgExpiry, msgMetadata];
    [self.messageBodyView loadHTMLString:display baseURL:nil];
    self.messageBodyView.backgroundColor = [UIColor clearColor];
    
    // We may have just marked a previously unread message as read. Update the badge counter.
    [BadgeManager refreshBadgeCount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
    if (!metadataKeys)
        return 0;
    return [metadataKeys count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [metadataKeys objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (!metadataKeys || [metadataKeys count] == 0)
        return;
    
    NSString *display = @"No metadata value for the key.";
    NSString *key = [metadataKeys objectAtIndex:row];
    if (key) {
        NSString *value = [message getMetadataValue:key];
        if (value)
            display = [NSString stringWithFormat:@"%@ = %@", key, value];
    }
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:display delegate:nil
                                              cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}

@end
