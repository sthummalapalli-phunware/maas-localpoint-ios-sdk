//
//  UnreadMessagesFilter.m
//  LocalpointTester_iOS
//
//  Created by Dev on 3/26/14.
//  Copyright (c) 2014 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "UnreadMessagesFilter.h"

@implementation UnreadMessagesFilter

// Only accepts valid messages that have not been read yet on the device.
- (BOOL)accept:(id)obj {
    if (![obj conformsToProtocol:@protocol(ILPMessage)])
        return FALSE;
    
    id<ILPMessage> msg = (id<ILPMessage>) obj;
    
    // Get instance of valid offer filter
    id<ILPMessageFilterFactory> filterFact = [[[LPLocalpointService instance] getMessageProvider] getFilterFactory];
    id<ILPFilter> validFilter = [filterFact getValidFilter];
    
    return [validFilter accept:msg] && ![msg isRead];
}

@end
