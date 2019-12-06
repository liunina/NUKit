//
//  NUViewController+ImagePicker.h
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import <NUKit/NUViewController.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NUImagePickerCompletionHandler)(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto);

@interface NUViewController (ImagePicker)

/// 打开自定义相册,包含拍照功能
/// @param pickCount 最多可选照片数量,最低为1,最多为9
/// @param completionHandler 多张照片回调
- (void)pickPhotoLibraryWithCount:(NSUInteger)pickCount
				completionHandler:(NUImagePickerCompletionHandler)completionHandler;

/// 打开一个自定义相册和拍照选取一个照片进行编辑返回指定大小的图片
/// @param imageSize 指定大小的图片
/// @param completionHandler 单张图片回调
- (void)pickImageWithPickImageCutImageWithImageSize:(CGSize)imageSize
								  completionHandler:(NUImagePickerCompletionHandler)completionHandler;
@end

NS_ASSUME_NONNULL_END
