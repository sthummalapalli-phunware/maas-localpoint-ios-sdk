//
//  ILPMessageListener.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPID;
@protocol ILPMessage;

/**
 A message listener receives updates concerning {@link ILPMessage messages}.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPMessageListener < NSObject >
@optional
/**
 Informs this listener that a new {@link ILPMessage message} has been added to the {@link ILPMessageProvider message provider} associated with the application.

 @param message The message that was added to the message provider (should never be <code>nil</code>)
 */
- (void)onAdd:(id<ILPMessage>)message;

/**
 Informs this listener that a {@link ILPMessage message} previously known to the {@link ILPMessageProvider message provider} associated with the application was deleted from the provider.

 @param id_ The unique identifier of the message that was deleted (should never be <code>nil</code>)
 */
- (void)onDelete:(id<ILPID>)id_;

/**
 Informs this listener that a {@link ILPMessage message} already known to the {@link ILPMessageProvider message provider} associated with the application was modified in some way.

 @param message The message that was modified (should never be <code>nil</code>)
 */
- (void)onModify:(id<ILPMessage>)message;

@end

#define ComDigbyLocalpointSdkCoreILPMessageListener ILPMessageListener
