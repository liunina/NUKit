//
//  NSBundle+NU.m
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import "NSBundle+NU.h"

@implementation NSBundle (NU)

+ (instancetype)bundleWithName:(NSString *)bundleName targetClass:(Class)targetClass {
    NSBundle *bundle = [NSBundle bundleForClass:targetClass];
    NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
    return url?[NSBundle bundleWithURL:url]:[NSBundle mainBundle];
}

@end
