//
//  ILPFilter.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

/**
 A filter can determine membership of any object in its domain within the set implied by this filter.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPFilter < NSObject >

/**
 Indicates whether the given object belongs to the set implicitly defined by this filter.

 @param obj The object to be tested for membership

 @return <code>YES</code> if the given object belongs to the set implicitly defined by this filter; <code>NO</code> otherwise
 */
- (BOOL)accept:(id)obj;

@end

#define ComDigbyLocalpointSdkCoreILPFilter ILPFilter
