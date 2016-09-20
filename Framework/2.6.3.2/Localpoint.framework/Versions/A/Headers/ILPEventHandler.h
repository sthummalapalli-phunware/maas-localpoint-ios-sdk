//
//  ILPEventHandler.h
//  Localpoint
//
//  Created by Xiangwei Wang on 1/28/15.
//
//

/**
 An common identifier which is used in location marketing.
 
 @version 1.1.0
 @since 1.0.0
 */

typedef NS_ENUM(NSInteger, LPEventType) {
    LPEventTypeEntry = 1,
    LPEventTypeExit = 2
};

@protocol ILPEventHandler < NSObject >

/**
 Proccess all kinds of events, this method could help fetch the related data from the server and save them in local cache.
 
 @param operationType The <code>ENUN</code> type of event, there are <code>LPEventTypeEntry</code> and <code>LPEventTypeExit</code> for now.
 
 @param geofenceId The unique Geo-fence identifier of location where the event happend, the <code>geofenceId<code> must be getting from location marketing SDK.
 
 @param completion The process result with an error, which is <code>nil</code> if it's successfull.
 
 */
- (void)process:(LPEventType)operationType geofenceId:(NSString*)geofenceId completion:(void(^)(NSError *error))completion;

@end


