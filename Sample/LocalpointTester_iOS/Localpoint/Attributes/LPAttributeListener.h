//
//  LPAttributeListener.h
//  LocalpointTester_iOS
//
//  Created by Quan Feng on 9/18/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LPAttributeListener : NSObject <ILPAttributeListener>

-(id) initWithTextView:(UITextView *)textView;

@end
