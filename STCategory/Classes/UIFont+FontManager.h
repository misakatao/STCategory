//
//  UIFont+FontManager.h
//  CPBaseKit
//
//  Created by MisakaTao on 2018/5/17.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kMajorLarge;/** 适⽤于少量重要性标题信息 (如导航标题、分类名称等) */
UIKIT_EXTERN CGFloat const kMajorSemiLarge;/** 适⽤于少量重要性标题信息 (如导航标题、分类名称等) */
UIKIT_EXTERN CGFloat const kMajorMedium;/** 适⽤于较为重要性标题信息 (如详情⻚停⻋场标题等) */
UIKIT_EXTERN CGFloat const kMajorRegular;/** 适⽤于较为重要性标题信息、操作按钮⽂字 (如模块标题，列表名称和价格等) */
UIKIT_EXTERN CGFloat const kNormalLarge;/** 适⽤于⼤多数⽂字 (特别适⽤于⼀般陈述和展示性⽂字等) */
UIKIT_EXTERN CGFloat const kNormalRegular;/** 适⽤于次要模块标题⽂字 (如搜索⻚模块标题、默认状态⼩标题等) */
UIKIT_EXTERN CGFloat const kSimpleLarge;/** 适⽤于辅助性⽂字 (如⼤多数备注信息等) */
UIKIT_EXTERN CGFloat const kSimpleRegular;/** 适⽤于极少数标识性⽂字 (如列表中状态⽂字等) */

@interface UIFont (FontManager)

/**
 苹方字体 亮字体
 */
+ (UIFont *)pingFangSCLight:(CGFloat)size;
/**
 苹方字体 常规字体
 */
+ (UIFont *)pingFangSCRegular:(CGFloat)size;
/**
 苹方字体 介于Regular和Semibold之间
 */
+ (UIFont *)pingFangSCMedium:(CGFloat)size;
/**
 苹方字体 半粗字体
 */
+ (UIFont *)pingFangSCSemibold:(CGFloat)size;
/**
 苹方字体 加粗字体
 */
+ (UIFont *)pingFangSCBold:(CGFloat)size;


@end
