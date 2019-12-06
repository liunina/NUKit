//
//  NUViewController+HUD.h
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import <NUKit/NUViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface NUViewController (HUD)
- (void)nl_showHudWithMessage:(NSString *)message;
- (void)nl_dismissHud;

- (void)nl_showInfo:(NSString *)info;
- (void)nl_showSuccess:(NSString *)successInfo;
- (void)nl_showError:(NSString *)errorInfo;
@end

NS_ASSUME_NONNULL_END
