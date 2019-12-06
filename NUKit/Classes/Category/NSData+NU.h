//
//  NSData+NU.h
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (NU)
- (NSString *)nl_base64EncodedString;
+ (NSData *)nl_dataWithBase64String:(NSString *)base64String;
@end

NS_ASSUME_NONNULL_END
