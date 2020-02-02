//
//  NUViewController.m
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import "NUViewController.h"
#import <HBDNavigationBar/HBDNavigationController.h>
#import <HBDNavigationBar/UIViewController+HBD.h>
#import <NUBlocksKit/BlocksKit+UIKit.h>

@interface NUViewController ()
@property (nonatomic, strong, readwrite) NUInterfaceEnv *uiEnv;
@end

@implementation NUViewController

- (instancetype)init {
	self = [super init];
	if (self) {
		
	};
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *presentingViewController = self.presentingViewController;
	if (self.dismissBlock && presentingViewController) {
		UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[leftBtn setTitle:@"取消" forState:UIControlStateNormal];
		leftBtn.frame = CGRectMake(0, 0, 80, 16);
		[leftBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
		leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
		[leftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
		__weak typeof(self) ws = self;
		[leftBtn bk_addEventHandler:^(id sender) {
			if (ws.dismissBlock) {
				ws.dismissBlock(ws);
			}
		} forControlEvents:UIControlEventTouchUpInside];
		UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
		
		UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		
		negativeSpacer.width = -16; // it was -6 in iOS 6
		[self.navigationItem setLeftBarButtonItems:@[negativeSpacer, btnItem]];
	}
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeAll;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
}

#pragma mark - getter
- (NUInterfaceEnv *)uiEnv {
	if (!_uiEnv) {
		 NUInterfaceEnv *uiEnv = [[NUInterfaceEnv alloc] init];
		 _uiEnv = uiEnv;
	 }
	 return _uiEnv;
}

@end
