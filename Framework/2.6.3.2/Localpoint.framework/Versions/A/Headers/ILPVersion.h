//
//  ILPVersion.h
//  Localpoint
//
//  Copyright (c) 2013 Phunware. All rights reserved.
//

/**
 A version describes the variant of the location marketing SDK installed in the application.

 @version 1.1.0
 @since 1.0.0
 */
@protocol ILPVersion < NSObject >

/**
 Returns the major version (most significant digit) of the location marketing SDK.

 @discussion This method should always return a positive value.
 
 @return the major version (most significant digit) of the location marketing SDK
 */
- (int)getMajorVersion;

/**
 Returns the minor version (second most significant digit) of the location marketing SDK.
 
 @discussion This method should always return a non-negative value.

 @return the minor version (second most significant digit) of the location marketing SDK
 */
- (int)getMinorVersion;

/**
 Returns the revision version (least significant digit) of the location marketing SDK.
 
 @discussion This method should always return a non-negative value.

 @return the revision version (least significant digit) of the location marketing SDK.
 */
- (int)getRevisionVersion;

/**
 Returns a printable form of this version.
 
 @discussion The return value of this method will take the form:
 <code>&lt;major-version&gt;.&lt;minor-version&gt;.&lt;revision-version&gt;</code>

 @return a printable form of this version
 */
- (NSString *)getValue;

@end

#define ComDigbyLocalpointSdkCoreILPVersion ILPVersion
