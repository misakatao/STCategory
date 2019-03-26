//
//  UIColor+Extension.h
//  CPBaseKit
//
//  Created by MisakaTao on 2017/2/7.
//  Copyright © 2017年 misakatao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 *  生成渐变色
 *
 *  @param c1     头
 *  @param c2     尾
 *  @param height 范围
 *
 *  @return 渐变色
 */
+ (UIColor *)gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 withHeight:(CGFloat)height;

/**
 *  生成随机色
 */
+ (UIColor *)randomColor;

/**
 *  由16进制颜色字符串格式生成UIColor
 *
 *  @param hexString 16进制颜色 #00FF00
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHex:(NSString *)hexString;
/**
 *  由16进制颜色字符串格式生成UIColor
 *
 *  @param hexString 16进制颜色 #00FF00
 *  @param alpha 透明
 *
 *  @return Color
 */
+ (UIColor *)colorWithHex:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 *  由16进制颜色格式生成UIColor
 *
 *  @param hexColor 16进制颜色0x00FF00
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexFloat:(uint32_t)hexColor;
/**
 *  由16进制颜色格式生成UIColor
 *
 *  @param hexColor 16进制颜色0x00FF00
 *  @param alpha 透明
 *
 *  @return Color
 */
+ (UIColor *)colorWithHexFloat:(uint32_t)hexColor alpha:(CGFloat)alpha;

/**
 *  生成当前颜色的16进制字符串
 */
- (NSString *)HEXString;
/**
 *  生成当前颜色的RBG值
 */
- (NSUInteger)rgbaValue;

@end
