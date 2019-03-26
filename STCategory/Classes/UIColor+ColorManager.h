//
//  UIColor+ColorManager.h
//  CPBaseKit
//
//  Created by MisakaTao on 2018/5/22.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorManager)


#pragma mark - 重要

/**
 主⾊调，⼩⾯积使⽤，⽤于特别需要突出和强调的⽂字、按钮、icon等
 如选中状态下标题⽂字、按钮等。
 */
+ (UIColor *)themeColor;
/**
 ⽤于重要级⽂字信息、内⻚标题信息
 如导航名称、类⽬名称等。
 */
+ (UIColor *)majorBlackColor;


#pragma mark - ⼀般

/**
 ⽤于说明性⽂字、普通级别段落信息
 如弹层⻚信息标题及填写完成状态等。
 */
+ (UIColor *)normalGrayColor;
/**
 ⽤于辅助性、次要⽂字信息
 如列表⻚信息未填写状态默认⽂字等。
 */
+ (UIColor *)normalLightColor;
/**
 ⽤于分割线、按钮描边等
 */
+ (UIColor *)normalThinColor;


#pragma mark - 较弱

/**
 ⽤于背景⾊，分个模块背景⾊
 如搜索导航栏背景⾊等。
 */
+ (UIColor *)simpleLightColor;


#pragma mark - 辅助

/**
 ⽤于辅助性图标及状态颜⾊

 @return 绿色
 */
+ (UIColor *)supGreenColor;
/**
 ⽤于辅助性图标及状态颜⾊

 @return 黄色
 */
+ (UIColor *)supYellowColor;
/**
 ⽤于辅助性图标及状态颜⾊

 @return 红色
 */
+ (UIColor *)supRedColor;


#pragma mark - 控件

/**
 上渐变：#4797FF

 @return 蓝色
 */
+ (UIColor *)shadeBlueTop;
/**
 下渐变：#6395FF

 @return 蓝色
 */
+ (UIColor *)shadeBlueBottom;

/**
 上渐变：#1DD884
 
 @return 绿色
 */
+ (UIColor *)shadeGreenTop;
/**
 下渐变：#0DDA92
 
 @return 绿色
 */
+ (UIColor *)shadeGreenBottom;

/**
 上渐变：#FFC526
 
 @return 黄色
 */
+ (UIColor *)shadeYellowTop;
/**
 下渐变：#FFB83A
 
 @return 黄色
 */
+ (UIColor *)shadeYellowBottom;


/**
 描边颜⾊
 */
+ (UIColor *)borderColor;



@end
