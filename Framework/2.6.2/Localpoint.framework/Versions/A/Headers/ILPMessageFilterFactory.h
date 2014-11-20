//
//  ILPMessageFilterFactory.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPFilter;

/**
 A message filter factory provides {@link ILPFilter filters} that operate on {@link ILPMessage messages}.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPMessageFilterFactory < NSObject >

/**
 Returns a filter that accepts all messages.

 @return a filter that accepts all messages
 */
- (id<ILPFilter>)getAllFilter;

/**
 Returns a filter that accepts expired messages.

 @return a filter that accepts expired messages
 */
- (id<ILPFilter>)getExpiredFilter;

/**
 Returns a filter that accepts valid messages.
 
 @return a filter that accepts valid messages
 */
- (id<ILPFilter>)getValidFilter;

@end
