//
//  PromotionViewController.h
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/21/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Localpoint/Localpoint.h>

@interface PromotionViewController : UIViewController
    <UIWebViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate> {
    id<ILPMessage> message;
}

@property(nonatomic,retain) id<ILPMessage> message;

@property (weak, nonatomic) IBOutlet UIWebView *messageBodyView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerMetadataKey;
@property (weak, nonatomic) IBOutlet UILabel *labelMetadataKey;

@end
