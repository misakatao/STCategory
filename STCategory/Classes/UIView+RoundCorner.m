//
//  UIView+RoundCorner.m
//  CPBaseKit
//
//  Created by MisakaTao on 2018/5/18.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import "UIView+RoundCorner.h"
#import <objc/runtime.h>

@implementation NSObject (_RoundCorner)

+ (void)cp_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)cp_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)cp_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)cp_removeAssociateWithKey:(void *)key {
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation UIImage (RoundCorner)

+ (UIImage *)cp_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)cp_maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    return [UIImage cp_imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        CGContextSetLineWidth(context, 0);
        [color set];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:corners cornerRadii:cornerRadii];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        if (!borderColor || !borderWidth) return;
        [borderColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }];
}

@end

static void *const _CPMaskCornerRadiusLayerKey = "_CPMaskCornerRadiusLayerKey";
static NSMutableSet<UIImage *> *maskCornerRaidusImageSet;

@implementation CALayer (RoundCorner)

+ (void)load{
    [CALayer cp_swizzleInstanceMethod:@selector(layoutSublayers) with:@selector(_cp_layoutSublayers)];
}

- (UIImage *)contentImage {
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.contents];
}

- (void)setContentImage:(UIImage *)contentImage {
    self.contents = (__bridge id)contentImage.CGImage;
}

- (void)cp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color {
    [self cp_roundedCornerWithRadius:radius cornerColor:color corners:UIRectCornerAllCorners];
}

- (void)cp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners {
    [self cp_roundedCornerWithCornerRadii:CGSizeMake(radius, radius) cornerColor:color corners:corners borderColor:nil borderWidth:0];
}

- (void)cp_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    if (!color) return;
    CALayer *cornerRadiusLayer = [self cp_getAssociatedValueForKey:_CPMaskCornerRadiusLayerKey];
    if (!cornerRadiusLayer) {
        cornerRadiusLayer = [CALayer new];
        cornerRadiusLayer.opaque = YES;
        [self cp_setAssociateValue:cornerRadiusLayer withKey:_CPMaskCornerRadiusLayerKey];
    }
    if (color) {
        [cornerRadiusLayer cp_setAssociateValue:color withKey:"_cp_cornerRadiusImageColor"];
    } else {
        [cornerRadiusLayer cp_removeAssociateWithKey:"_cp_cornerRadiusImageColor"];
    }
    [cornerRadiusLayer cp_setAssociateValue:[NSValue valueWithCGSize:cornerRadii] withKey:"_cp_cornerRadiusImageRadius"];
    [cornerRadiusLayer cp_setAssociateValue:@(corners) withKey:"_cp_cornerRadiusImageCorners"];
    if (borderColor) {
        [cornerRadiusLayer cp_setAssociateValue:borderColor withKey:"_cp_cornerRadiusImageBorderColor"];
    }else{
        [cornerRadiusLayer cp_removeAssociateWithKey:"_cp_cornerRadiusImageBorderColor"];
    }
    [cornerRadiusLayer cp_setAssociateValue:@(borderWidth) withKey:"_cp_cornerRadiusImageBorderWidth"];
    UIImage *image = [self _cp_getCornerRadiusImageFromSet];
    if (image) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = image;
        [CATransaction commit];
    }
}

- (UIImage *)_cp_getCornerRadiusImageFromSet {
    
    if (!self.bounds.size.width || !self.bounds.size.height) return nil;
    CALayer *cornerRadiusLayer = [self cp_getAssociatedValueForKey:_CPMaskCornerRadiusLayerKey];
    UIColor *color = [cornerRadiusLayer cp_getAssociatedValueForKey:"_cp_cornerRadiusImageColor"];
    if (!color) return nil;
    CGSize radius = [[cornerRadiusLayer cp_getAssociatedValueForKey:"_cp_cornerRadiusImageRadius"] CGSizeValue];
    NSUInteger corners = [[cornerRadiusLayer cp_getAssociatedValueForKey:"_cp_cornerRadiusImageCorners"] unsignedIntegerValue];
    CGFloat borderWidth = [[cornerRadiusLayer cp_getAssociatedValueForKey:"_cp_cornerRadiusImageBorderWidth"] floatValue];
    UIColor *borderColor = [cornerRadiusLayer cp_getAssociatedValueForKey:"_cp_cornerRadiusImageBorderColor"];
    if (!maskCornerRaidusImageSet) {
        maskCornerRaidusImageSet = [NSMutableSet new];
    }
    __block UIImage *image = nil;
    [maskCornerRaidusImageSet enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
        CGSize imageSize = [[obj cp_getAssociatedValueForKey:"_cp_cornerRadiusImageSize"] CGSizeValue];
        UIColor *imageColor = [obj cp_getAssociatedValueForKey:"_cp_cornerRadiusImageColor"];
        CGSize imageRadius = [[obj cp_getAssociatedValueForKey:"_cp_cornerRadiusImageRadius"] CGSizeValue];
        NSUInteger imageCorners = [[obj cp_getAssociatedValueForKey:"_cp_cornerRadiusImageCorners"] unsignedIntegerValue];
        CGFloat imageBorderWidth = [[obj cp_getAssociatedValueForKey:"_cp_cornerRadiusImageBorderWidth"] floatValue];
        UIColor *imageBorderColor = [obj cp_getAssociatedValueForKey:"_cp_cornerRadiusImageBorderColor"];
        BOOL isBorderSame = (CGColorEqualToColor(borderColor.CGColor, imageBorderColor.CGColor) && borderWidth == imageBorderWidth) || (!borderColor && !imageBorderColor) || (!borderWidth && !imageBorderWidth);
        BOOL canReuse = CGSizeEqualToSize(self.bounds.size, imageSize) && CGColorEqualToColor(imageColor.CGColor, color.CGColor) && imageCorners == corners && CGSizeEqualToSize(radius, imageRadius) && isBorderSame;
        if (canReuse) {
            image = obj;
            *stop = YES;
        }
    }];
    if (!image) {
        image = [UIImage cp_maskRoundCornerRadiusImageWithColor:color cornerRadii:radius size:self.bounds.size corners:corners borderColor:borderColor borderWidth:borderWidth];
        [image cp_setAssociateValue:[NSValue valueWithCGSize:self.bounds.size] withKey:"_cp_cornerRadiusImageSize"];
        [image cp_setAssociateValue:color withKey:"_cp_cornerRadiusImageColor"];
        [image cp_setAssociateValue:[NSValue valueWithCGSize:radius] withKey:"_cp_cornerRadiusImageRadius"];
        [image cp_setAssociateValue:@(corners) withKey:"_cp_cornerRadiusImageCorners"];
        if (borderColor) {
            [image cp_setAssociateValue:color withKey:"_cp_cornerRadiusImageBorderColor"];
        }
        [image cp_setAssociateValue:@(borderWidth) withKey:"_cp_cornerRadiusImageBorderWidth"];
        [maskCornerRaidusImageSet addObject:image];
    }
    return image;
}

#pragma mark - exchage Methods

- (void)_cp_layoutSublayers {
    [self _cp_layoutSublayers];
    
    CALayer *cornerRadiusLayer = [self cp_getAssociatedValueForKey:_CPMaskCornerRadiusLayerKey];
    if (cornerRadiusLayer) {
        UIImage *aImage = [self _cp_getCornerRadiusImageFromSet];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = aImage;
        cornerRadiusLayer.frame = self.bounds;
        [CATransaction commit];
        [self addSublayer:cornerRadiusLayer];
    }
}

@end

@implementation UIView (RoundCorner)

/**
 设置一个四角圆角
 @param radius 圆角半径
 @param color  圆角背景色
 */
- (void)cp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color {
    
    [self.layer cp_roundedCornerWithRadius:radius cornerColor:color];
}

/**
 设置一个普通圆角
 @param radius  圆角半径
 @param color   圆角背景色
 @param corners 圆角位置
 */
- (void)cp_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners {
    
    [self.layer cp_roundedCornerWithRadius:radius cornerColor:color corners:corners];
}

/**
 设置一个带边框的圆角
 @param cornerRadii 圆角半径cornerRadii
 @param color       圆角背景色
 @param corners     圆角位置
 @param borderColor 边框颜色
 @param borderWidth 边框线宽
 */
- (void)cp_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    [self.layer cp_roundedCornerWithCornerRadii:cornerRadii cornerColor:color corners:corners borderColor:borderColor borderWidth:borderWidth];
}

@end
