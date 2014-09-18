//
//  ILPMessage.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPID;

/**
 A message is a communication (generally marketing related) sent from the server.

 @version 2.4.0
 @since 1.0.0
 */
@protocol ILPMessage < NSObject >

/**
 Returns the body of this message.
 
 @discussion The value returned by this method is usually HTML. This method should never return <code>nil</code>.

 @return the body of this message
 */
- (NSString *)getBody;

/**
 Returns the expiration date of this message.
 
 @discussion An application may wish to display messages differently based on their expiration dates. This method should never return <code>nil</code>.

 @return the expiration date of this message
 */
- (NSDate *)getExpirationDate;

/**
 Returns the internal unique identifier of the campaign with which this message is associated.
 
 @discussion At any given time, there can be at most one message associated with a campaign. This method should never return <code>nil</code>.
 
 @return the internal unique identifier of the campaign with which this message is associated
 */
- (id<ILPID>)getID;

/**
 Returns the title of this message.
 
 @discussion This method should never return <code>nil</code>.
 
 @return the title of this message
 */
- (NSString *)getTitle;

/**
 Indicates whether this message has been read.
 
 @discussion A message is considered read if {@link #getBody()} has been called on it.
 
 @return <code>YES</code> if this message has been read; <code>NO</code> otherwise
 */
- (BOOL)isRead;

/**
 Returns the metadata of this message.

 @discussion This method should never return <code>nil</code>: it returns an empty Map if there is no metadata associated with the message.
 
 @return the metadata of this message
 */
- (NSDictionary *)getMetadata;

/**
 Returns the message metadata value for a key.
 
 @discussion This method returns <code>nil</code> if the metadata does not contain an entry with the key.
 
 @param key the key of the metadata entry
 
 @return the value of the metadata entry
 */
- (NSString *)getMetadataValue:(NSString *)key;

@end

#define ComDigbyLocalpointSdkCoreILPMessage ILPMessage
