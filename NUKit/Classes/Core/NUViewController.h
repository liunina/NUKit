//
//  NUViewController.h
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "NUInterfaceEnv.h"

NS_ASSUME_NONNULL_BEGIN

@class NUViewController;
typedef void(^NUViewControllerDismissBlock)(NUViewController *vc);

@interface NUViewController : UIViewController
/// 界面配置
@property (nonatomic, strong, readonly) NUInterfaceEnv *uiEnv;
///	当控制器是present时该控制器dismiss时的回调
@property (nonatomic, copy) NUViewControllerDismissBlock dismissBlock;
@end

NS_ASSUME_NONNULL_END
