//
//  NSBundle+NU.h
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define NUKitBundle(bundleName, targetClass) [NSBundle bundleWithName:bundleName targetClass:targetClass]

@interface NSBundle (NU)

/// 通弄过名称和类目寻找bundle
/// @param bundleName 资源名称
/// @param targetClass 调用类
+ (instancetype)bundleWithName:(NSString *)bundleName targetClass:(Class)targetClass;
@end

NS_ASSUME_NONNULL_END
