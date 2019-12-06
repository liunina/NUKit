//
//  NSString+NU.m
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import "NSString+NU.h"
#import "NSData+NU.h"

@implementation NSString (NU)

+ (BOOL)isVaild:(NSString *)string {
	if (!string) {
		return NO;
	}
	
	if ([string trim].length == 0) {
		return NO;
	}
	
	if ([string isEqual:[NSNull null]]) {
		return NO;
	}
    
	return YES;
}

+ (BOOL)isEmpty:(NSString *)string {
    return !string || [string trim].length == 0;
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - URL Encoding and Unencoding
- (NSString *)URLEncodedString {
	NSCharacterSet *chaSet = [NSCharacterSet characterSetWithCharactersInString:@"'();:@&=+$,/?%#[]"];
	return [self stringByAddingPercentEncodingWithAllowedCharacters:chaSet];
}

- (NSString *)URLEncodedParameterString {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)URLDecodedString {
    return [self stringByRemovingPercentEncoding];
}

#pragma mark - Base64 Encoding
- (NSString *)nl_base64EncodedString {
    if ([self length] == 0) {
        return nil;
    }

    return [[self dataUsingEncoding:NSUTF8StringEncoding] nl_base64EncodedString];
}

+ (NSString *)nl_stringWithBase64String:(NSString *)base64String {
    return [[NSString alloc] initWithData:[NSData nl_dataWithBase64String:base64String] encoding:NSUTF8StringEncoding];
}

@end
