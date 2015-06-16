//
//  ILPTag.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

/**
 A tag describes a {@link ILPLocation location}.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPTag < NSObject >

/**
 Returns the name of this tag.
 
 @discussion This method should never return <code>nil</code>.

 @return the name of this tag
 */
- (NSString *)getName;

@end

#define ComDigbyLocalpointSdkCoreILPTag ILPTag
