//
//  ILPOrdering.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#define ILPOrdering_FIRST_EQUAL_TO_SECOND 0
#define ILPOrdering_FIRST_GREATER_THAN_SECOND 1
#define ILPOrdering_FIRST_LESS_THAN_SECOND -1

/**
 An ordering can determine the relative ordering of any two objects in a domain.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPOrdering < NSObject >

/**
 Compares the two given arguments according to this ordering.
 
 @discussion A <code>nil</code> argument should never be less than any other argument.

 @param arg1 The first argument to be compared
 @param arg2 The second argument to be compared
 
 @return Either {@link #FIRST_LESS_THAN_SECOND}, {@link #FIRST_EQUAL_TO_SECOND} or {@link #FIRST_GREATER_THAN_SECOND}, depending on whether the first argument is less than, equal to, or greater than the second argument in this ordering
 */
- (int)compare:(id)arg1 withId:(id)arg2;
@end

/**
 An ordering can determine the relative ordering of any two objects in a domain.
 
 @version 1.1.0
 @since 1.0.0
 */
@interface ILPOrdering : NSObject {
}

/**
 The value returned by {@link #compare(Object, Object)} if the first argument precedes the second argument in this ordering.
 */
+ (int)FIRST_LESS_THAN_SECOND;

/**
 The value returned by {@link #compare(Object, Object)} if the first argument neither precedes nor succeeds the second argument in this ordering.
 */
+ (int)FIRST_EQUAL_TO_SECOND;

/**
 The value returned by {@link #compare(Object, Object)} if the first argument succeeds the second argument in this ordering.
 */
+ (int)FIRST_GREATER_THAN_SECOND;

@end

#define ComDigbyLocalpointSdkCoreILPOrdering ILPOrdering
