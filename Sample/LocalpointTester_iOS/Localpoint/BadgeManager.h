//
//  BadgeManager.h
//  LocalpointTester_iOS
//
//  Created by Dev on 3/26/14.
//  Copyright (c) 2014 Jason Schmitt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BadgeManager : NSObject

+ (int) badgeCount;

+ (void) refreshBadgeCount;

@end
