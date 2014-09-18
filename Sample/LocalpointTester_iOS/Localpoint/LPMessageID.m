//
//  LPMessageID.m
//  LocalpointTester_iOS
//
//  Created by Carl on 11/14/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import "LPMessageID.h"

@implementation LPMessageID

@synthesize value;

-(id)init{
    return [self initWithString:@"0"];
}

-(id)initWithString:(NSString *) stringValueArg{
    self = [super init];
    if(self){
        value = stringValueArg;
    }
    return self;
}

- (NSString *)getValue{
    return value;
}

- (BOOL) isEqual:(id)object {
    if (![object conformsToProtocol:@protocol(ILPID)])
        return NO;
    
    LPMessageID *otherID = (LPMessageID *)object;
    return [value isEqualToString:[otherID getValue]];
}

- (NSUInteger) hash {
    return [value hash];
}

@end
