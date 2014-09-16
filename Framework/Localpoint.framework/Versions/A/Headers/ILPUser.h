//
//  ILPUser.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPAttributeManager;

/**
 The user of the Localpoint service.

 @version 2.3.0
 @since 2.3.0
 */
@protocol ILPUser < NSObject >

/**
 Returns the object managing user attributes.

 @return the user attribute manager
 */
- (id<ILPAttributeManager>)getAttributeManager;

@end

#define ComDigbyLocalpointSdkCoreILPUser ILPUser
