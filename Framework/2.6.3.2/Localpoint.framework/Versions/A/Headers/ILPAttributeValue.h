//
//  ILPAttributeValue.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

/**
 This interface defines the generic type for the attribute value of a device. Currently supported value types are
 <code>NSString</code>,
 <code>NSInteger</code> and
 <code>Boolean</code>.
 
 @version 2.3.0
 @since 2.3.0
 */
@protocol ILPAttributeValue < NSObject >

/**
 Returns the attribute value.
 
 @return the attribute value
 */
- (id)getValue;

@end
