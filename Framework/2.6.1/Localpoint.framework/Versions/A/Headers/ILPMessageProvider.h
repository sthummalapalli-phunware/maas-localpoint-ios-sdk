//
//  ILPMessageProvider.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPMessageFilterFactory;
@protocol ILPMessageOrderingFactory;
@protocol ILPFilter;
@protocol ILPID;
@protocol ILPMessage;
@protocol ILPMessageListener;
@protocol ILPOrdering;

/**
 A message provider acts as a store for messages deemed &quot;relevant&quot;
 by the SDK.

 @warnning A message provider can be used by an application in two ways:
 <ol>
 <li><i>synchronous</i> - the provider can be queried for messages currently known to it.</li>
 <li><i>asynchronous</i> - an application can register a {@link ILPMessageListener listener} that will be notified when messages known are added to, deleted from, or modified in the provider.</li>
 </ol>

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPMessageProvider < NSObject >

/**
 Adds the given listener to this provider.
 
 @param listener The listener to be added (must never be <code>nil</code>)
 */
- (void)addListener:(id<ILPMessageListener>)listener;

/**
 Returns the {@link ILPMessageFilterFactory message filter factory} associated with this provider.

 @discussion This method should never return <code>nil</code>.
 
 @return the {@link ILPMessageFilterFactory message filter factory} associated with this provider
 */
- (id<ILPMessageFilterFactory>)getFilterFactory;

/**
 Returns a message with the given identifier.
 
 @param id_ The identifier of the message to be returned (must never be <code>nil</code>)

 @return the message with the given identifier, if such a message is currently known to this provider, or <code>nil</code> otherwise
 */
- (id<ILPMessage>)getMessage:(id<ILPID>)id_;

/**
 Returns all messages known to this provider.
 
 @discussion This is equivalent to calling {@link #getMessages(ILPFilter, ILPOrdering)} with <code>nil</code> for both arguments.
 
 @return the (possibly empty) list of messages known to this provider
 */
- (NSArray *)getMessages;

/**
 Returns all messages filtered by the given filter and sorted by the given ordering.
 
 @param filter The filter to be applied to the messages to be returned (if <code>nil</code>, acts as a filter that accepts all messages -- see {@link ILPMessageFilterFactory#getAllFilter()})
 @param ordering The ordering to be applied to the messages to be returned (if <code>nil</code>, acts as {@link ILPMessageOrderingFactory#getAscendingExpirationOrdering()})

 @return the (possibly empty) list of messages that satisfy the given filter and ordering
 */
- (NSArray *)getMessages:(id<ILPFilter>)filter withOrdering:(id<ILPOrdering>)ordering;

/**
 Returns the {@link ILPMessageOrderingFactory message ordering factory} associated with this provider.
 
 @discussion This method should never return <code>nil</code>.

 @return the {@link ILPMessageOrderingFactory message ordering factory} associated with this provider
 */
- (id<ILPMessageOrderingFactory>)getOrderingFactory;

/**
 Removes all listeners from this provider.
 */
- (void)removeAllListeners;

/**
 Removes the given listener from this provider.
 
 @discussion This method has no effect if the given listener is not registered with this provider.

 @param listener The listener to remove (must never be <code>nil</code>)
 */
- (void)removeListener:(id<ILPMessageListener>)listener;

@end

#define ComDigbyLocalpointSdkCoreILPMessageProvider ILPMessageProvider
