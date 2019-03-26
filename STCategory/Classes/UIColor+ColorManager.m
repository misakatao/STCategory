//
//  UIColor+ColorManager.m
//  CPBaseKit
//
//  Created by MisakaTao on 2018/5/22.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import "UIColor+ColorManager.h"
#import "UIColor+Extension.h"

@implementation UIColor (ColorManager)

#pragma mark - 重要

/**
 主⾊调，⼩⾯积使⽤，⽤于特别需要突出和强调的⽂字、按钮、icon等
 如选中状态下标题⽂字、按钮等。
 */
+ (UIColor *)themeColor {
    return [UIColor colorWithHex:@"#4897FF"];
}
/**
 ⽤于重要级⽂字信息、内⻚标题信息
 如导航名称、类⽬名称等。
 */
+ (UIColor *)majorBlackColor {
    return [UIColor colorWithHex:@"#3A3F49"];
}


#pragma mark - ⼀般

/**
 ⽤于说明性⽂字、普通级别段落信息
 如弹层⻚信息标题及填写完成状态等。
 */
+ (UIColor *)normalGrayColor {
    return [UIColor colorWithHex:@"#666C78"];
}
/**
 ⽤于辅助性、次要⽂字信息
 如列表⻚信息未填写状态默认⽂字等。
 */
+ (UIColor *)normalLightColor {
    return [UIColor colorWithHex:@"#A3AABA"];
}
/**
 ⽤于分割线、按钮描边等
 */
+ (UIColor *)normalThinColor {
    return [UIColor colorWithHex:@"#E6EBEF"];
}


#pragma mark - 较弱

/**
 ⽤于背景⾊，分个模块背景⾊
 如搜索导航栏背景⾊等。
 */
+ (UIColor *)simpleLightColor {
    return [UIColor colorWithHex:@"#F0F2F3"];
}


#pragma mark - 辅助

/**
 ⽤于辅助性图标及状态颜⾊
 
 @return 绿色
 */
+ (UIColor *)supGreenColor {
    return [UIColor colorWithHex:@"#25D77E"];
}
/**
 ⽤于辅助性图标及状态颜⾊
 
 @return 黄色
 */
+ (UIColor *)supYellowColor {
    return [UIColor colorWithHex:@"#FFBD2E"];
}
/**
 ⽤于辅助性图标及状态颜⾊
 
 @return 红色
 */
+ (UIColor *)supRedColor {
    return [UIColor colorWithHex:@"#FF5F57"];
}


#pragma mark - 控件

/**
 上渐变：#4797FF
 
 @return 蓝色
 */
+ (UIColor *)shadeBlueTop {
    return [UIColor colorWithHex:@"#4797FF"];
}
/**
 下渐变：#6395FF
 
 @return 蓝色
 */
+ (UIColor *)shadeBlueBottom {
    return [UIColor colorWithHex:@"#6395FF"];
}

/**
 上渐变：#1DD884
 
 @return 绿色
 */
+ (UIColor *)shadeGreenTop {
    return [UIColor colorWithHex:@"#1DD884"];
}
/**
 下渐变：#0DDA92
 
 @return 绿色
 */
+ (UIColor *)shadeGreenBottom {
    return [UIColor colorWithHex:@"#0DDA92"];
}

/**
 上渐变：#FFC526
 
 @return 黄色
 */
+ (UIColor *)shadeYellowTop {
    return [UIColor colorWithHex:@"#FFC526"];
}
/**
 下渐变：#FFB83A
 
 @return 黄色
 */
+ (UIColor *)shadeYellowBottom {
    return [UIColor colorWithHex:@"#FFB83A"];
}

/**
 描边颜⾊
 */
+ (UIColor *)borderColor {
    return [UIColor colorWithHex:@"#E6EBEF"];
}


@end
