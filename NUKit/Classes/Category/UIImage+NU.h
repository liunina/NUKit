//
//  UIImage+NU.h
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define NUKitImage(imgName, bundleName, targetClass) [UIImage nl_imageNamed:imgName bundleName:bundleName targetClass:targetClass]

@interface UIImage (NU)

#pragma mark - 颜色相关

/// 通过颜色生成一个(1,1)像素的图片
/// @param color 颜色
+ (nullable UIImage *)nl_imageWithColor:(UIColor *)color;

/// 通过颜色和尺寸生成图片
/// @param color 颜色
/// @param size 图片大小
+ (nullable UIImage *)nl_imageWithColor:(UIColor *)color size:(CGSize)size;

#pragma mark - 资源包Bundle

/// 通过图片名和资源包等查找图片
/// @param name 图片名称
/// @param bundleName 资源包名称
/// @param targetClass 调用类
+ (UIImage *)nl_imageNamed:(NSString *)name bundleName:(NSString *)bundleName targetClass:(Class)targetClass;

#pragma mark - 压缩 NSData

/// 对图片进行指定的数据大小压缩的数据
/// @param maxLength 最大数据大小
- (NSData *)nl_compressWithMaxLength:(NSUInteger)maxLength;

#pragma mark - 剪切

/// 返回调整的缩略图
- (UIImage *)nl_fitInSize:(CGSize)viewsize;
/// 返回居中的缩略图
- (UIImage *)nl_centerInSize:(CGSize)viewsize;
/// 返回填充的缩略图
- (UIImage *)nl_fillSize:(CGSize)viewsize;

#pragma mark - 圆角

/// 通过配置大小和背景色进行圆角剪切,该函数配置原型
/// @param size 需要结果图片的大小
/// @param fillColor 背景色填充
/// @param completion 回调
- (void)nl_roundImageWithSize:(CGSize)size
					fillColor:(UIColor *)fillColor
				   completion:(void (^)(UIImage *))completion;

/// 通过配置大小,填充背景色,圆角大小进行圆角设置
/// @param size 图片大小
/// @param fillColor 填充色
/// @param radius 圆角大小
/// @param completion 结果回调
- (void)nl_roundRectImageWithSize:(CGSize)size
						fillColor:(UIColor *)fillColor
						   radius:(CGFloat)radius
					   completion:(void (^)(UIImage *))completion;
@end

NS_ASSUME_NONNULL_END
