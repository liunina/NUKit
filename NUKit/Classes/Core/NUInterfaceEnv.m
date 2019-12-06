//
//  NUInterfaceEnv.m
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import "NUInterfaceEnv.h"

@implementation NUInterfaceEnv

- (instancetype)init {
    self = [super init];
    if (self) {
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        _statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _safeAreaBottomHeight = ((_screenHeight == 812.0) || (_screenHeight == 896)) ? 34 : 0;
        _navBarHeight = 44;
        
        _navHeight = _navBarHeight + _statusBarHeight;
        _tabBarHeight = ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49);
        _screenHeightNoNavBar = _screenHeight - _navHeight - _safeAreaBottomHeight;
        _screenHeightTabBar = _screenHeight - _navHeight - _tabBarHeight;
        _screenHeightTabBarNoNavBar = _screenHeight - _statusBarHeight - _tabBarHeight;
        _screenHeightNoStatusBar = _screenHeight - _statusBarHeight;
    }
    return self;
}
@end
