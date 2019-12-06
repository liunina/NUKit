//
//  NSString+NU.h
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NU)

/// 判断是否有效(是否为真,是否为null,是否是空字符串)
/// @param string 字符串
+ (BOOL)isVaild:(NSString *)string;

/// 判断是否是空字符串
/// @param string 字符串
+ (BOOL)isEmpty:(NSString *)string;

/// 去空格
- (NSString *)trim;

#pragma mark - URL Encoding and Unencoding
- (NSString *)URLEncodedString ;
- (NSString *)URLEncodedParameterString ;
- (NSString *)URLDecodedString;

#pragma mark - BASE64
- (NSString *)nl_base64EncodedString;
+ (NSString *)nl_stringWithBase64String:(NSString *)base64String;
@end

NS_ASSUME_NONNULL_END
