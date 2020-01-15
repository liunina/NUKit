//
//  NUViewController+ImagePicker.m
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import "NUViewController+ImagePicker.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <objc/runtime.h>

static void *kNUImagePickerCompletionHandlerKey = @"kImagePickerCompletionHandlerKey";
static void *kNUCameraPickerKey = @"kCameraPickerKey";
static void *kNUTZImagePickerController = @"kTZImagePickerController";

static void *kNUImageSizeKey = @"kimageSizeKey";
static void *kNUPhotoCountPickKey = @"kPhotoCountPickKey";
static void *isNUCut =  @"isCut"; //截取

@interface NUViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end
@implementation NUViewController (ImagePicker)

- (void)pickPhotoLibraryWithCount:(NSUInteger)pickCount
				completionHandler:(NUImagePickerCompletionHandler)completionHandler {
	self.completionHandler = completionHandler;
	self.photoCountPick = pickCount;
	[self setUpPhotoPickController];
	__weak typeof(self) ws = self;
	[self requestPhotoLibraryAuthorizationCompletionValidHandler:^{
		[ws.tzPickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
			ws.completionHandler(photos, assets, isSelectOriginalPhoto);
		}];
		
		ws.tzPickerController.modalPresentationStyle = UIModalPresentationFullScreen;
		[ws presentViewController:ws.tzPickerController animated:YES completion:nil];
	}];
}

- (void)pickImageWithPickImageCutImageWithImageSize:(CGSize)imageSize
								  completionHandler:(NUImagePickerCompletionHandler)completionHandler {
	self.completionHandler = completionHandler;
	self.photoCountPick = 1;
	self.isCutImageBool = YES;
	self.imageSize = imageSize;
	
	[self setUpPhotoPickController];
	__weak typeof(self) ws = self;
	[self requestPhotoLibraryAuthorizationCompletionValidHandler:^{
		[ws.tzPickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
			ws.completionHandler(photos, assets, isSelectOriginalPhoto);
		}];
		
		ws.tzPickerController.modalPresentationStyle = UIModalPresentationFullScreen;
		[ws presentViewController:ws.tzPickerController animated:YES completion:nil];
	}];
}

///	创建相机控制器
- (void)setUpCameraPickControllerIsEdit:(BOOL)isEdit {
	self.cameraPicker = [[UIImagePickerController alloc] init];
	self.cameraPicker.allowsEditing = isEdit; //拍照选去是否可以截取，和代理中的获取截取后的方法配合使用
	self.cameraPicker.delegate = self;
	self.cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
}

/// 创建自定义相册
- (void)setUpPhotoPickController {
	TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.photoCountPick
																						columnNumber:4
																							delegate:nil
																				   pushPhotoPickerVc:YES];
	imagePickerVc.isSelectOriginalPhoto = YES;
	imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
	imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频
	imagePickerVc.navigationBar.translucent = YES;
	imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
	imagePickerVc.showPhotoCannotSelectLayer = YES;
	imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
	[imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
		[doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	}];
	
	imagePickerVc.allowPickingVideo = NO;
	imagePickerVc.allowPickingImage = YES;
	imagePickerVc.allowPickingOriginalPhoto = YES;
	imagePickerVc.allowPickingGif = NO;
	imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
	imagePickerVc.sortAscendingByModificationDate = YES;
	imagePickerVc.showSelectBtn = NO;
	imagePickerVc.allowCrop = self.isCutImageBool;
	imagePickerVc.needCircleCrop = NO;
	
	// 设置竖屏下的裁剪尺寸
	NSInteger left = 10;
	NSInteger widthHeight = self.view.bounds.size.width - 2 * left;
	NSInteger top = (self.view.bounds.size.height - widthHeight) / 2;
	imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
	if (self.imageSize.width > 0 && self.imageSize.height > 0) {
		left = (self.view.bounds.size.width - self.imageSize.width) / 2;
		top = (self.view.bounds.size.height - self.imageSize.height) / 2;
		imagePickerVc.cropRect = CGRectMake(left, top, self.imageSize.width, self.imageSize.height);
	}
	
	imagePickerVc.scaleAspectFillCrop = YES;
	imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
	// 设置是否显示图片序号
	imagePickerVc.showSelectedIndex = NO;
	
	self.tzPickerController = imagePickerVc;
}

- (void)requestAccessForMediaType:(AVMediaType)mediaType completionValidHandler:(void (^)(void))handler {
	[AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if (granted) {
				if (handler) {
					handler();
				}
			}else {
				UIAlertController *noticeAlertController = [UIAlertController alertControllerWithTitle:@"未开启相机权限，请到设置界面开启" message:nil preferredStyle:UIAlertControllerStyleAlert];
				
				UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
																	   style:UIAlertActionStyleCancel
																	 handler:nil];
				
				UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"现在就去"
																   style:UIAlertActionStyleDefault
																 handler:^(UIAlertAction * _Nonnull action) {
					if (@available(iOS 10.0, *)) {
						[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
					} else {
						// Fallback on earlier versions
						[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
					};
				}];
				
				[noticeAlertController addAction:cancelAction];
				[noticeAlertController addAction:okAction];
				[self presentViewController:noticeAlertController animated:YES completion:^{
					
				}];
			}
		});
	}];
}
- (void)requestPhotoLibraryAuthorizationCompletionValidHandler:(void (^)(void))handler {
	//判断相册权限
	[PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
		dispatch_async(dispatch_get_main_queue(), ^{
			if (status == PHAuthorizationStatusNotDetermined || status == PHAuthorizationStatusAuthorized) {
				if (handler) {
					handler();
				}
			} else {
				UIAlertController *noticeAlertController = [UIAlertController
															alertControllerWithTitle:@"未开启相册权限，请到设置界面开启"
															message:nil
															preferredStyle:UIAlertControllerStyleAlert];
				UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
																	   style:UIAlertActionStyleCancel
																	 handler:nil];
				
				UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"现在就去"
																   style:UIAlertActionStyleDefault
																 handler:^(UIAlertAction * _Nonnull action) {
					//跳转到设置界面
					if (@available(iOS 10.0, *)) {
						[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
					} else {
						// Fallback on earlier versions
						[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
					};
				}];
				
				[noticeAlertController addAction:cancelAction];
				[noticeAlertController addAction:okAction];
				[self presentViewController:noticeAlertController animated:YES completion:^{
				}];
			}
		});
	}];
}

#pragma mark - setters & getters
- (void)setCameraPicker:(UIImagePickerController *)cameraPicker {
	objc_setAssociatedObject(self, kNUCameraPickerKey, cameraPicker, OBJC_ASSOCIATION_RETAIN);
}

- (UIImagePickerController *)cameraPicker {
	return objc_getAssociatedObject(self, kNUCameraPickerKey);;
}
- (void)setCompletionHandler:(NUImagePickerCompletionHandler)completionHandler {
	objc_setAssociatedObject(self, kNUImagePickerCompletionHandlerKey, completionHandler, OBJC_ASSOCIATION_COPY);
}

- (NUImagePickerCompletionHandler)completionHandler {
	return objc_getAssociatedObject(self, kNUImagePickerCompletionHandlerKey);
}

- (void)setTzPickerController:(TZImagePickerController *)tzPickerController {
	objc_setAssociatedObject(self, kNUTZImagePickerController, tzPickerController, OBJC_ASSOCIATION_RETAIN);
}

- (TZImagePickerController *)tzPickerController {
	return objc_getAssociatedObject(self, kNUTZImagePickerController);
}

- (void)setIsCutImageBool:(BOOL)isCutImageBool {
	return objc_setAssociatedObject(self, isNUCut, @(isCutImageBool), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isCutImageBool {
	return [objc_getAssociatedObject(self, isNUCut) boolValue];
}

- (void)setImageSize:(CGSize)imageSize {
	return objc_setAssociatedObject(self, kNUImageSizeKey, [NSValue valueWithCGSize:imageSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)imageSize {
	NSValue * value = objc_getAssociatedObject(self, kNUImageSizeKey);
	return  value.CGSizeValue;
}

- (void)setPhotoCountPick:(NSUInteger)count {
	if (count < 1) {
		count = 1;
	}
	
	if(count > 9) {
		count = 9;
	}
	return objc_setAssociatedObject(self, kNUPhotoCountPickKey, @(count), OBJC_ASSOCIATION_RETAIN);
}

- (NSUInteger)photoCountPick {
	return  [objc_getAssociatedObject(self, kNUPhotoCountPickKey) integerValue];
}
@end
