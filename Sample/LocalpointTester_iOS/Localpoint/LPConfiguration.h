//
//  LPConfiguration.h
//  Localpoint
//
//  Created by Kevin Alexander on 1/22/13.
//
//

#import <Foundation/Foundation.h>


@interface LPConfiguration : NSObject 

@property(nonatomic, readonly) NSString *server;
@property(nonatomic, readonly) NSString *brand;
@property(nonatomic, readonly) NSString *appID;
@property(nonatomic, readonly) int searchRadius;

- (NSString *) localpointServerRootURL;
- (NSString *) localpointEventServiceURL;

+ (LPConfiguration *)instance;

@end
