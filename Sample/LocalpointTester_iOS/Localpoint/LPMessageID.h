//
//  LPMessageID.h
//  LocalpointTester_iOS
//
//  Created by Carl on 11/14/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import <Foundation/Foundation.h>

@interface LPMessageID : NSObject<ILPID>

@property(nonatomic, readonly) NSString* value;

- (id) initWithString:(NSString *) stringValueArg;

@end
