//
//  UIColor+Extension.h
//  CPBaseKit
//
//  Created by MisakaTao on 2017/2/7.
//  Copyright © 2017年 misakatao. All rights reserved.
//

#import "UIColor+Extension.h"

UIColor *ColorARGB(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
    
//    if (@available(iOS 10_0, *)) {
//        return [UIColor colorWithDisplayP3Red:((CGFloat)red/255.0f)
//                                        green:((CGFloat)green/255.0f)
//                                         blue:((CGFloat)blue/255.0f)
//                                        alpha:(CGFloat)alpha];
//    } else {
//    }
    return [UIColor colorWithRed:((CGFloat)red/255.0f)
                           green:((CGFloat)green/255.0f)
                            blue:((CGFloat)blue/255.0f)
                           alpha:(CGFloat)alpha];
}

CGFloat ColorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    // 从16进制字符串中扫描一个无符号整型数值
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}


@implementation UIColor (Extension)

+ (UIColor *)gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 withHeight:(CGFloat)height {
    
    CGSize size = CGSizeMake(1, height); // 这个宽度无所谓，只要不是0就行
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    // 创建渐变色
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    // 填充到画布
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 回收内存
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}


+ (UIColor *)randomColor {
    
    NSUInteger red = (arc4random() % 255);
    NSUInteger green = (arc4random() % 255);
    NSUInteger blue = (arc4random() % 255);
    return ColorARGB(red, green, blue, 1.0);
}

+ (UIColor *)colorWithHex:(NSString *)hexString {
    
    return [self colorWithHex:hexString alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSString *)hexString alpha:(CGFloat)alpha {
    
    NSString *valueString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if (valueString.length < 6) return [UIColor clearColor];
    
    // strip 0X if it appears
    if ([valueString hasPrefix:@"0X"]) valueString = [valueString substringFromIndex:2];
    if ([valueString hasPrefix:@"#"]) valueString = [valueString substringFromIndex:1];
    
    if ([valueString length] != 6) return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    //r
    NSString *rString = [valueString substringWithRange:NSMakeRange(0, 2)];
    //g
    NSString *gString = [valueString substringWithRange:NSMakeRange(2, 2)];
    //b
    NSString *bString = [valueString substringWithRange:NSMakeRange(4, 2)];
    
    // Scan values
    unsigned r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return ColorARGB(r, g, b, alpha);
}

+ (UIColor *)colorWithHexFloat:(uint32_t)hexColor {
    
    return [self colorWithHexFloat:hexColor alpha:1.0];
}

+ (UIColor *)colorWithHexFloat:(uint32_t)hexColor alpha:(CGFloat)alpha {
    
    CGFloat red = (CGFloat)((hexColor & 0xFF0000) >> 16);
    CGFloat green = (CGFloat)((hexColor & 0xFF00) >> 8);
    CGFloat blue = (CGFloat)(hexColor & 0xFF);
    return ColorARGB(red, green, blue, alpha);
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    
    CGFloat alpha, red, blue, green;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = ColorComponentFrom(colorString, 0, 1);
            green = ColorComponentFrom(colorString, 1, 1);
            blue  = ColorComponentFrom(colorString, 2, 1);
            break;
            
        case 4: // #ARGB
            alpha = ColorComponentFrom(colorString, 0, 1);
            red   = ColorComponentFrom(colorString, 1, 1);
            green = ColorComponentFrom(colorString, 2, 1);
            blue  = ColorComponentFrom(colorString, 3, 1);
            break;
            
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = ColorComponentFrom(colorString, 0, 2);
            green = ColorComponentFrom(colorString, 2, 2);
            blue  = ColorComponentFrom(colorString, 4, 2);
            break;
            
        case 8: // #AARRGGBB
            alpha = ColorComponentFrom(colorString, 0, 2);
            red   = ColorComponentFrom(colorString, 2, 2);
            green = ColorComponentFrom(colorString, 4, 2);
            blue  = ColorComponentFrom(colorString, 6, 2);
            break;
            
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSString *)HEXString {
    
    UIColor *color = self;
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0] * 255.0),
            (int)((CGColorGetComponents(color.CGColor))[1] * 255.0),
            (int)((CGColorGetComponents(color.CGColor))[2] * 255.0)];
}

- (NSUInteger)rgbaValue {
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        NSUInteger rr = (NSUInteger)(r * 255 + 0.5);
        NSUInteger gg = (NSUInteger)(g * 255 + 0.5);
        NSUInteger bb = (NSUInteger)(b * 255 + 0.5);
        NSUInteger aa = (NSUInteger)(a * 255 + 0.5);
        
        return (rr << 24) | (gg << 16) | (bb << 8) | aa;
    } else {
        return 0;
    }
}

@end
