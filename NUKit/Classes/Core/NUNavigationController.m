//
//  NUNavigationController.m
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import "NUNavigationController.h"

@interface NUNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NUNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *topViewController = self.topViewController;
    return [topViewController preferredStatusBarStyle];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        //屏蔽调用rootViewController的滑动返回手势，避免右滑返回手势引起死机问题
        if (self.viewControllers.count < 2 ||
            self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;//这里就是非右滑手势调用的方法啦，统一允许激活
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if(self.viewControllers.count != 0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
