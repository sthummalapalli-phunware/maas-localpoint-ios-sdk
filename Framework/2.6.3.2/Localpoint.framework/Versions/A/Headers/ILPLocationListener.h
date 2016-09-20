//
//  ILPLocationListener.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

@protocol ILPID;
@protocol ILPLocation;

/**
 A location listener receives updates concerning {@link ILPLocation locations}.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPLocationListener < NSObject >
@optional
/**
 Informs this listener that a new {@link ILPLocation location} has been added to the {@link ILPLocationProvider location provider} associated with the application.

 @param location The location that was added to the location provider (should never be <code>nil</code>)
 */
- (void)onAdd:(id<ILPLocation>)location;

/**
 Notifies this listener of a failed check-in.

 @param location The location at which the failed check-in was to have occurred (should never be <code>nil</code>)
 @param error The error that caused the failure (should never be <code>nil</code>)
 */
- (void)onCheckInFailure:(id<ILPLocation>)location withError:(NSError *)error;

/**
 Notifies this listener of a successful check-in.
 *
 @param location The location at which the successful check-in occurred (should never be <code>nil</code>)
 */
- (void)onCheckInSuccess:(id<ILPLocation>)location;

/**
 Informs this listener that a {@link ILPLocation location} previously known to the {@link ILPLocationProvider location provider} associated with the application was deleted from the provider.

 @param id_ The unique identifier of the location that was deleted (should never be <code>nil</code>)
 */
- (void)onDelete:(id<ILPID>)id_;

/**
 Informs this listener that the server has determined that the given {@link ILPLocation location} has been entered.

 @param location The location that was entered (should never be <code>nil</code>)
 */
- (void)onEntry:(id<ILPLocation>)location;

/**
 Informs this listener that the server has determined that the given {@link ILPLocation location} has been exited.

 @param location The location that was exited (should never be <code>nil</code>)
 */
- (void)onExit:(id<ILPLocation>)location;

/**
 Informs this listener that a {@link ILPLocation location} already known to the {@link ILPLocationProvider location provider} associated with the application was modified in some way.

 @param location The location that was modified (should never be <code>nil</code>)
 */
- (void)onModify:(id<ILPLocation>)location;

@end

#define ComDigbyLocalpointSdkCoreILPLocationListener ILPLocationListener
