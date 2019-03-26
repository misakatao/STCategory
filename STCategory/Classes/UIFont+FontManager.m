//
//  UIFont+FontManager.m
//  CPBaseKit
//
//  Created by MisakaTao on 2018/5/17.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import "UIFont+FontManager.h"

CGFloat const kMajorLarge = 21.0;/** 适⽤于少量重要性标题信息 (如导航标题、分类名称等) */
CGFloat const kMajorSemiLarge = 18.0;/** 适⽤于少量重要性标题信息 (如导航标题、分类名称等) */
CGFloat const kMajorMedium = 17.0;/** 适⽤于较为重要性标题信息 (如详情⻚停⻋场标题等) */
CGFloat const kMajorRegular = 16.0;/** 适⽤于较为重要性标题信息、操作按钮⽂字 (如模块标题，列表名称和价格等) */
CGFloat const kNormalLarge = 14.0;/** 适⽤于⼤多数⽂字 (特别适⽤于⼀般陈述和展示性⽂字等) */
CGFloat const kNormalRegular = 13.0;/** 适⽤于次要模块标题⽂字 (如搜索⻚模块标题、默认状态⼩标题等) */
CGFloat const kSimpleLarge = 12.0;/** 适⽤于辅助性⽂字 (如⼤多数备注信息等) */
CGFloat const kSimpleRegular = 10.0;/** 适⽤于极少数标识性⽂字 (如列表中状态⽂字等) */




@implementation UIFont (FontManager)

/**
UIFontWeightUltraLight  - 超细字体 @"PingFangSC-Ultralight"
UIFontWeightThin        - 纤细字体 @"PingFangSC-Thin"
UIFontWeightLight       - 亮字体 @"PingFangSC-Light"
UIFontWeightRegular     - 常规字体 @"PingFangSC-Regular"
UIFontWeightMedium      - 介于Regular和Semibold之间 @"PingFangSC-Medium"
UIFontWeightSemibold    - 半粗字体 @"PingFangSC-Semibold"
UIFontWeightBold        - 加粗字体
UIFontWeightHeavy       - 介于Bold和Black之间
UIFontWeightBlack       - 最粗字体(理解)
**/

/*
 UIFontDescriptorFamilyAttribute：设置字体家族名
 UIFontDescriptorNameAttribute  ：设置字体的字体名
 UIFontDescriptorSizeAttribute  ：设置字体尺寸
 UIFontDescriptorMatrixAttribute：设置字体形变
 */


/**
 苹方字体 亮字体
 */
+ (UIFont *)pingFangSCLight:(CGFloat)size {
    
    if (@available(iOS 9.0, *)) {
        NSDictionary *attributes = @{
                                     UIFontDescriptorFamilyAttribute:@"PingFang SC",
                                     UIFontDescriptorNameAttribute:@"PingFangSC-Light",
                                     };
        UIFontDescriptor *descriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:attributes];
        return [UIFont fontWithDescriptor:descriptor size:size];
    } else if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:size weight:UIFontWeightLight];
    } else {
        return [UIFont systemFontOfSize:size];
    }
}

/**
 苹方字体 常规字体
 */
+ (UIFont *)pingFangSCRegular:(CGFloat)size {
    
    if (@available(iOS 9.0, *)) {
        NSDictionary *attributes = @{
                                     UIFontDescriptorFamilyAttribute:@"PingFang SC",
                                     UIFontDescriptorNameAttribute:@"PingFangSC-Regular",
                                     };
        UIFontDescriptor *descriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:attributes];
        return [UIFont fontWithDescriptor:descriptor size:size];
    } else if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
    } else {
        return [UIFont systemFontOfSize:size];
    }
}

/**
 苹方字体 介于Regular和Semibold之间
 */
+ (UIFont *)pingFangSCMedium:(CGFloat)size {
    
    if (@available(iOS 9.0, *)) {
        NSDictionary *attributes = @{
                                     UIFontDescriptorFamilyAttribute:@"PingFang SC",
                                     UIFontDescriptorNameAttribute:@"PingFangSC-Medium",
                                     };
        UIFontDescriptor *descriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:attributes];
        return [UIFont fontWithDescriptor:descriptor size:size];
    } else if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
    } else {
        return [UIFont systemFontOfSize:size];
    }
}

/**
 苹方字体 半粗字体
 */
+ (UIFont *)pingFangSCSemibold:(CGFloat)size {
    
    if (@available(iOS 9.0, *)) {
        NSDictionary *attributes = @{
                                     UIFontDescriptorFamilyAttribute:@"PingFang SC",
                                     UIFontDescriptorNameAttribute:@"PingFangSC-Semibold",
                                     };
        UIFontDescriptor *descriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:attributes];
        return [UIFont fontWithDescriptor:descriptor size:size];
    } else if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:size weight:UIFontWeightSemibold];
    } else {
        return [UIFont boldSystemFontOfSize:size];
    }
}

/**
 苹方字体 加粗字体
 */
+ (UIFont *)pingFangSCBold:(CGFloat)size {
    
    if (@available(iOS 9.0, *)) {
        NSDictionary *attributes = @{
                                     UIFontDescriptorFamilyAttribute:@"PingFang SC",
                                     UIFontDescriptorNameAttribute:@"PingFangSC-Bold",
                                     };
        UIFontDescriptor *descriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:attributes];
        return [UIFont fontWithDescriptor:descriptor size:size];
    } else if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:size weight:UIFontWeightBold];
    } else {
        return [UIFont boldSystemFontOfSize:size];
    }
}


@end
