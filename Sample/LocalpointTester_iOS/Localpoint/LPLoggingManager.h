//
//  LPLoggingManager.h
//  Localpoint
//
//  Created by Jason Schmitt on 7/5/13.
//
//

#import <Foundation/Foundation.h>
#import <Localpoint/Localpoint.h>

@interface LPLoggingManager : NSObject {
    @private
    __unsafe_unretained id<LPLoggingDelegate> internalLogger;
}

/*!
 *
 *   @discussion
 *     Debugging statements, usefull for testing
 */
@property (assign) id<LPLoggingDelegate> internalLogger;

/** Accessor to singleton instance of the logging manager
  */
+ (LPLoggingManager *) instance;

/** Method for interal-only logs from the Localpoint SDK.
  */
+ (void) logInternal:(NSString *)format, ...;

/** Method for external logs that the implementing app can use for troubleshooting purposes.
  */
+ (void) logExternal:(NSString *)format, ...;

/** Gets the path to the log file
  */
+ (NSString *) logFilePath;

@end
