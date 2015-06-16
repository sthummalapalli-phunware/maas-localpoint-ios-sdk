//
//  ILPAttributeListener.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

/**
 A listener that receives notifications on attribute updates of a device.
 
 @version 2.3.0
 @since 2.3.0
 */
@protocol ILPAttributeListener < NSObject >
@optional
/**
 Notifies this listener of a failed update.
 
 @param attrs The attributes that were submitted in the failed update (should never be <code>nil</code>)
 @param error The error that caused the failure (should never be <code>nil</code>)
 */
- (void)onUpdateFailure:(NSDictionary *)attrs withError:(NSError *)error;

/**
 Notifies this listener of a successful update.
 
 @param attrs The attributes that were submitted successfully in the update (should never be <code>nil</code>)
 */
- (void)onUpdateSuccess:(NSDictionary *)attrs;
@end
