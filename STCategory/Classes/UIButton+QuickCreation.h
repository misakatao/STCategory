//
//  UIButton+QuickCreation.h
//  CPBaseKit
//
//  Created by MisakaTao on 2017/8/15.
//  Copyright © 2017年 misakatao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CPButtonEdgeInsetsStyle) {
    CPButtonEdgeInsetsStyleTop, // image在上，label在下
    CPButtonEdgeInsetsStyleLeft, // image在左，label在右
    CPButtonEdgeInsetsStyleBottom, // image在下，label在上
    CPButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (QuickCreation)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(CPButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

@end
