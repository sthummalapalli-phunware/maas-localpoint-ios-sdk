//
//  ILPMessageOrderingFactory.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPOrdering;

/**
 A location ordering factory provides {@link ILPOrdering orderings} that operate on {@link ILPMessage messages}.
 
 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPMessageOrderingFactory < NSObject >

/**
 Returns a filter that sorts messages by ascending expiration date.

 @return a filter that sorts messages by ascending expiration date
 */
- (id<ILPOrdering>)getAscendingExpirationOrdering;

/**
 Returns a filter that sorts messages by descending expiration date.

 @return a filter that sorts messages by descending expiration date
 */
- (id<ILPOrdering>)getDescendingExpirationOrdering;

@end
