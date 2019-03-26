//
//  UIView+RoundCorner.h
//  CPBaseKit
//
//  Created by MisakaTao on 2018/5/18.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RoundCorner)

/**
 设置一个四角圆角
 @param radius 圆角半径
 @param color  圆角背景色
 */
- (void)cp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color;

/**
 设置一个普通圆角
 @param radius  圆角半径
 @param color   圆角背景色
 @param corners 圆角位置
 */
- (void)cp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

/**
 设置一个带边框的圆角
 @param cornerRadii 圆角半径cornerRadii
 @param color       圆角背景色
 @param corners     圆角位置
 @param borderColor 边框颜色
 @param borderWidth 边框线宽
 */
- (void)cp_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end

@interface CALayer (RoundCorner)

/**如下分别对应UIView的相应API*/

- (void)cp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color;

- (void)cp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

- (void)cp_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
