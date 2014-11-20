//
//  ILPAttributeManager.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

typedef void (^LPServerProcessCompletion)(NSDictionary *attributes, NSError *error);

@protocol ILPAttributeListener;

/**
 This interface defines the object managing profile and user attributes. The manager is responsible for updating the attributes and asynchronously notifying the listener of the update result.
 
 @version 2.3.0
 @since 2.3.0
 */
@protocol ILPAttributeManager < NSObject >
/**
 Updates the profile attributes.
 *
 @param attrs The new profile attributes to be associated with the device. <code>attrs</code> become the complete set of the profile attributes - any existing attributes not in <code>attrs</code> are removed.
 */
- (void)updateProfileAttributes:(NSDictionary *)attrs;

/**
 Updates the user attributes.

 Note: Currently only one user attribute named "ID1" is supported; its value must be a string. Any other attributes are ignored.

 @param attrs new user attributes to be associated with the device. <code>attrs</code> become the complete set of the user attributes - any existing attributes not in <code>attrs</code> are removed.
 */
- (void)updateUserAttributes:(NSDictionary *)attrs;

/**
 Adds the attribute listener to the manager.

 @param listener The listener to be added (must not be <code>nil</code>)
 */
- (void)addListener:(id<ILPAttributeListener>)listener;

/**
 Removes the given listener from the manager.

 @discussion This method has no effect if the given listener is not registered with this manager.

 @param listener The listener to remove (must not be <code>nil</code>)
 */
- (void)removeListener:(id<ILPAttributeListener>)listener;

/**
 Removes all listeners from the manager.
 */
- (void)removeAllListeners;

/**
 Get user attribute
 
 @param The block returns user attribute or error
 */
- (void)getUserAttributes:(LPServerProcessCompletion)completion;

/**
 Get profile attribute
 
 @param The block returns profile attribute or error
 */
- (void)getProfileAttributes:(LPServerProcessCompletion)completion;

@end
