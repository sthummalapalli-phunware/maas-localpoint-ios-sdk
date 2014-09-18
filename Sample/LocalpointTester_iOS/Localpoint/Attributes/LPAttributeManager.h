//
//  LPAttributeManager.h
//  Localpoint
//
//  Created by Quan Feng on 7/10/13.
//
//

#import <Localpoint/Localpoint.h>
#import <Foundation/Foundation.h>

@class LPAuthenticationHelper;

@interface LPAttributeManager : NSObject <ILPAttributeManager>

@property(nonatomic, strong) LPAuthenticationHelper *authenticationHelper;

- (id) initWithDeviceId:(NSString *)did localpointServerRootURL:(NSString *)url;

- (NSString *) getDeviceId;
- (NSString *) getLPServerRootURL;
- (NSString *) getProfileURI;
- (NSString *) getUserURI;
- (NSOperationQueue *) getOperationQueue;

- (NSDictionary *) profileAttributesUpdateRequestBody:(NSDictionary *)attrs;
// Returns error message on failure and nil on success
- (NSString *) profileAttributesUpdateTask:(NSDictionary *)attrs;

- (NSData *) userAttributesUpdateRequestBody:(NSDictionary *)attrs;
// Returns error message on failure and nil on success
- (NSString *) userAttributesUpdateTask:(NSDictionary *)attrs;

// Do POST if notif is not nil, otherwise do GET
- (NSString *) doRequest:(NSMutableURLRequest *)request
                 withURI:(NSString *)uri
            notification:(NSMutableDictionary *)notif;

// Return nil if no problem, otherwise return an error string
- (NSString *) postRequest:(NSMutableDictionary *)notif
              returnedData:(NSData *)rtData
                  response:(NSURLResponse *)resp
                     error:(NSError *)err;

@end
