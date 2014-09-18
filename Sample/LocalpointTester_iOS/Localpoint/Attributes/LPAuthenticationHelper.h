//
//  LPAuthenticationHelper.h
//  Localpoint
//
//  Created by Quan Feng on 8/16/13.
//
//

#import <Foundation/Foundation.h>

@interface LPAuthenticationHelper : NSObject

-(id)initWithAppId:(NSString *)aid brandCode:(NSString *)bc;

-(NSString *) generateAuthHeaderValue:(NSString *)uri reqParams:(NSString *)rp reqBody:(NSString *)rb;

+(NSString *)generateSignature:(NSString *)secretKry
                   timeStamp:(long long)ts
                      userId:(NSString *)uid
                    userType:(NSString *)ut
                         uri:(NSString *)uri
                   reqParams:(NSString *)rp
                     reqBody:(NSString *)rb;

+(NSString*)sha256Hex:(NSString*)input;

+ (NSString *)base64String:(NSString *)str;

+ (NSString *) percentEncodeString:(NSString *)str;

@end
