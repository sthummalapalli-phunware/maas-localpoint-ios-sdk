//
//  LPAttributeListener.m
//  LocalpointTester_iOS
//
//  Created by Quan Feng on 9/18/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import "LPAttributeListener.h"
#import "LPLoggingManager.h"

@implementation LPAttributeListener {
@private
    __weak UITextView *resultTextView;
}

- (id)init {
    return [self initWithTextView:nil];
}

-(id) initWithTextView:(UITextView *)textView {
    self = [super init];
    if (self)
        resultTextView = textView;
    return self;
}

- (void) onUpdateSuccess:(NSDictionary *)attrs {
    NSString *infoMsg =
    [NSString stringWithFormat:@"Successfully sent attributes to Localpoint: %@", [attrs description]];
    [resultTextView performSelectorOnMainThread:@selector(setText:) withObject:infoMsg waitUntilDone:NO];
    [LPLoggingManager logExternal:infoMsg];
}

- (void) onUpdateFailure:(NSDictionary *)attrs withError:(NSError *)error {
    NSString *errMsg = [NSString stringWithFormat:@"Failed to send attributes to Localpoint. Error: %d. %@",
                        [error code], [error description]];
    [resultTextView performSelectorOnMainThread:@selector(setText:) withObject:errMsg waitUntilDone:NO];
    [LPLoggingManager logExternal:errMsg];
}

@end
