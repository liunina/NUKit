//
//  UIImage+NU.m
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import "UIImage+NU.h"
#import "NSBundle+NU.h"

@implementation UIImage (NU)

#pragma mark - 颜色相关
+ (UIImage *)nl_imageWithColor:(UIColor *)color {
    return [self nl_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)nl_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 资源包Bundle
+ (UIImage *)nl_imageNamed:(NSString *)name bundleName:(NSString *)bundleName targetClass:(Class)targetClass {
    NSBundle *bundle = nil;
	bundle = NUKitBundle(bundleName, targetClass);
    UIImage *image = [UIImage imageNamed:name
                                inBundle:bundle
           compatibleWithTraitCollection:nil];
    return image;
}

#pragma mark - 压缩 NSData
- (NSData *)nl_compressWithMaxLength:(NSUInteger)maxLength {
    
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}

#pragma mark - 剪切
- (CGSize)fitSize:(CGSize)thisSize inSize:(CGSize)aSize {
	CGFloat scale;
	CGSize newsize = thisSize;
	
	if (newsize.height && (newsize.height > aSize.height)) {
		scale = aSize.height / newsize.height;
		newsize.width *= scale;
		newsize.height *= scale;
	}
	
	if (newsize.width && (newsize.width >= aSize.width)) {
		scale = aSize.width / newsize.width;
		newsize.width *= scale;
		newsize.height *= scale;
	}
	
	return newsize;
}

/// 返回调整的缩略图
- (UIImage *)nl_fitInSize:(CGSize)viewsize {

	// calculate the fitted size
	CGSize size = [self fitSize:self.size inSize:viewsize];
	
	UIGraphicsBeginImageContext(viewsize);
	
	float dwidth = (viewsize.width - size.width) / 2.0f;
	float dheight = (viewsize.height - size.height) / 2.0f;
	
	CGRect rect = CGRectMake(dwidth, dheight, size.width, size.height);
	[self drawInRect:rect];
	
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newimg;
}
/// 返回居中的缩略图
- (UIImage *)nl_centerInSize:(CGSize)viewsize {
	CGSize size = self.size;
	
	UIGraphicsBeginImageContext(viewsize);
	float dwidth = (viewsize.width - size.width) / 2.0f;
	float dheight = (viewsize.height - size.height) / 2.0f;
	
	CGRect rect = CGRectMake(dwidth, dheight, size.width, size.height);
	[self drawInRect:rect];
	
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newimg;
}
/// 返回填充的缩略图
- (UIImage *)nl_fillSize:(CGSize)viewsize {
	CGSize size = self.size;
	
	CGFloat scalex = viewsize.width / size.width;
	CGFloat scaley = viewsize.height / size.height;
	CGFloat scale = MAX(scalex, scaley);
	
	UIGraphicsBeginImageContext(viewsize);
	
	CGFloat width = size.width * scale;
	CGFloat height = size.height * scale;
	
	float dwidth = ((viewsize.width - width) / 2.0f);
	float dheight = ((viewsize.height - height) / 2.0f);
	
	CGRect rect = CGRectMake(dwidth, dheight, size.width * scale, size.height * scale);
	[self drawInRect:rect];
	
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newimg;
}
#pragma mark - 圆角
- (void)nl_roundImageWithSize:(CGSize)size
					fillColor:(UIColor *)fillColor
				   completion:(void (^)(UIImage *))completion {
	
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		UIGraphicsBeginImageContextWithOptions(size, YES, 0);
		CGRect rect = CGRectMake(0, 0, size.width, size.height);
		[fillColor setFill];
		UIRectFill(rect);
		UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
		[path addClip];
		[self drawInRect:rect];
		UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();

		dispatch_async(dispatch_get_main_queue(), ^{
			if (completion != nil) {
				completion(result);
			}
		});
	});
}

/// 圆角矩形
- (void)nl_roundRectImageWithSize:(CGSize)size
						fillColor:(UIColor *)fillColor
						   radius:(CGFloat)radius
					   completion:(void (^)(UIImage *))completion {
	
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		UIGraphicsBeginImageContextWithOptions(size, YES, 0);
		CGRect rect = CGRectMake(0, 0, size.width, size.height);
		[fillColor setFill];
		UIRectFill(rect);
		UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
		[path addClip];
		[self drawInRect:rect];
		UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		dispatch_async(dispatch_get_main_queue(), ^{
			if (completion != nil) {
				completion(result);
			}
		});
	});
}

@end
