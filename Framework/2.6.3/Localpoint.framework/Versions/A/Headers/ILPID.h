//
//  ILPID.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

/**
 An common identifier which is used in location marketing.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPID < NSObject >

/**
 Returns the string representation of this identifier.

 @discussion This method should never return <code>nil</code>.

 @return the string representation of this identifier
 */
- (NSString *)getValue;

@end

#define ComDigbyLocalpointSdkCoreILPID ILPID
