//
//  TmpAttributeManager2.h
//  Localpoint
//
//  Created by Quan Feng on 9/18/13.
//
//

#import <Foundation/Foundation.h>
#import "LPAttributeManager.h"


//We should combine this protocol into ILPAttributeListener (instead of extending)
//in the future if we need to support GET in ILPAttributeManager
@protocol TmpAttributesRetrievalListener <NSObject>
- (void)onGetFailure:(NSError *)error;
- (void)onGetSuccess:(NSString *)result;
@end

@interface TmpAttributeManager2 : LPAttributeManager

//These GET methods should be added to ILPAttributeManager if we need to support GET 
//in ILPAttributeManager
- (void)getProfileAttributes;
- (void)getUserAttributes;

//These listener methods can be dropped if we combine TmpAttributesRetrievalListener
//into ILPAttributeListener
- (void)addRetrievalListener:(id<TmpAttributesRetrievalListener>)listener;
- (void)removeRetrievalListener:(id<TmpAttributesRetrievalListener>)listener;
- (void)removeRetrievalAllListeners;

@end
