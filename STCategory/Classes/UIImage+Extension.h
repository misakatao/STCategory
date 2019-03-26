//
//  UIImage+Extension.h
//  CPCategory
//
//  Created by MisakaTao on 2018/5/23.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/** 拍照时防止照片旋转  */
- (UIImage *)fixOrientation;

/** 截取方形图片  */
+ (UIImage *)drowAImage:(UIImage *)img;

- (UIImage *)drawImageWithSize:(CGSize)size;

- (UIImage *)scaleWithMaxPixels:(CGFloat)maxPixels;

- (UIImage *)scaleToSize:(CGSize)newSize;

- (UIImage *)externalScaleSize:(CGSize)scaledSize;

- (UIImage *)thumb;

- (UIImage *)thumbForSNS:(NSInteger)count;

- (UIImage *)makeImageRounded;

+ (UIImage *)resoulImage:(UIImage *)resutImage constWidth:(CGFloat)width;

+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

- (UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size;

@end
