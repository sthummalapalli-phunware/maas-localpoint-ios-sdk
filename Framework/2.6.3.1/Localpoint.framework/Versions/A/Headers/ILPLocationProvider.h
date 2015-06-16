//
//  ILPLocationProvider.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPLocationFilterFactory;
@protocol ILPLocationOrderingFactory;
@protocol ILPFilter;
@protocol ILPID;
@protocol ILPLocation;
@protocol ILPLocationListener;
@protocol ILPOrdering;

/**
 A location provider acts as a store for locations deemed &quot;relevant&quot; by the SDK.
 
 @discussion A location provider can be used by an application in two ways:
 <ol>
 <li><i>synchronous</i> - The provider can be queried for locations currently known to it.</li>
 <li><i>asynchronous</i> - An application can register a {@link ILPLocationListener listener} that will be notified when locations known are added to, deleted from or modified in the provider.</li>
 </ol>
 </p>

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPLocationProvider < NSObject >

/**
 Adds the given listener to this provider.

 @param listener The listener to be added (must never be <code>nil</code>)
 */
- (void)addListener:(id<ILPLocationListener>)listener;

/**
 Returns the {@link ILPLocationFilterFactory location filter factory} associated with this provider.
 
 @discussion This method should never return <code>nil</code>.

 @return the {@link ILPLocationFilterFactory location filter factory} associated with this provider
 */
- (id<ILPLocationFilterFactory>)getFilterFactory;

/**
 Returns a location with the given identifier.
 
 @param id_ The identifier of the location to be returned (must never be <code>nil</code>)

 @return the location with the given identifier or <code>nil</code>
 */
- (id<ILPLocation>)getLocation:(id<ILPID>)id_;

/**
 Returns all locations known to this provider.

 @discussion This is equivalent to calling {@link #getLocations(ILPFilter, ILPOrdering)} with <code>nil</code> for both arguments.

 @return the (possibly empty) list of locations known to this provider
 */
- (NSArray *)getLocations;

/**
 Returns all locations filtered by the given filter and sorted by the given ordering.

 @param filter The filter to be applied to the locations to be returned (if <code>nil</code>, acts as a filter that accepts all locations see {@link ILPLocationFilterFactory#getAllFilter()})
 @param ordering The ordering to be applied to the locations to be returned (if <code>nil</code>, acts as {@link ILPLocationOrderingFactory#getAscendingDistanceOrdering()})

 @return the (possibly empty) list of locations that satisfy the given filter and ordering
 */
- (NSArray *)getLocations:(id<ILPFilter>)filter withOrdering:(id<ILPOrdering>)ordering;

/**
 Returns the {@link ILPLocationOrderingFactory location ordering factory} associated with this provider.

 @discussion This method should never return <code>nil</code>.

 @return the {@link ILPLocationOrderingFactory location ordering factory} associated with this provider
 */
- (id<ILPLocationOrderingFactory>)getOrderingFactory;

/**
 Removes all listeners from this provider.
 */
- (void)removeAllListeners;

/**
 Removes the given listener from this provider.
 
 @discussion This method has no effect if the given listener is not registered with this provider.

 @param listener The listener to remove (must never be <code>nil</code>)
 */
- (void)removeListener:(id<ILPLocationListener>)listener;

@end

#define ComDigbyLocalpointSdkCoreILPLocationProvider ILPLocationProvider
