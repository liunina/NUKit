//
//  NUInterfaceEnv.h
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NUInterfaceEnv : NSObject
/// 屏幕宽度
@property(nonatomic, assign) CGFloat screenWidth;
/// 屏幕高度
@property(nonatomic, assign) CGFloat screenHeight;
/// 系统状态栏高度
@property(nonatomic, assign) CGFloat statusBarHeight;
/// 系统TabBar高度 + 安全距离
@property(nonatomic, assign) CGFloat tabBarHeight;
/// iPhone X 安全距离
@property(nonatomic, assign) CGFloat safeAreaBottomHeight;
/// 导航栏高度
@property(nonatomic, assign) CGFloat navBarHeight;
/// 状态栏 + 导航栏
@property(nonatomic, assign) CGFloat navHeight;
/// 屏幕高度 - 状态栏 - 导航栏 - tabBar - 安全距离
@property(nonatomic, assign) CGFloat screenHeightTabBar;
/// 屏高 - 状态栏高度 - tabBar - 安全距离
@property(nonatomic, assign) CGFloat screenHeightTabBarNoNavBar;
/// 屏高 - 状态栏 - 导航栏 - 安全距离
@property(nonatomic, assign) CGFloat screenHeightNoNavBar;
/// 屏幕高度 - 状态栏
@property(nonatomic, assign) CGFloat screenHeightNoStatusBar;
@end

NS_ASSUME_NONNULL_END
