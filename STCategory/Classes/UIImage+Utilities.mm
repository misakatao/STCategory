//
//  UIImage+Utilities.m
//  yixin_iphone
//
//  Created by zqf on 13-1-18.
//  Copyright (c) 2013年 Netease. All rights reserved.
//

#import "UIImage+Utilities.h"
#import <vector>
#import "NSData+Base64.h"


static std::vector<std::vector<CGPoint> > *offsets = 0;

void CalculateBoxStyle(NSArray *images,CGFloat &boxSize,std::vector<CGPoint> **vt)
{
    const CGFloat kMutiBoxSize  = 0.54;
    const CGFloat kOneBoxSize   = 1.0;
    NSInteger count = [images count];
    if (count >= 3)
    {
        boxSize = kMutiBoxSize;
    }
    else
    {
        boxSize = kOneBoxSize;
    }
    
    if (offsets == 0)
    {
        
        const CGFloat kPadding = 0.01; //防止圆形切边
        //一张头像的布局
        std::vector<CGPoint> one;
        one.push_back(CGPointMake(0,0));
        
        //三张图形的布局
        std::vector<CGPoint> three;
        three.push_back(CGPointMake(kPadding ,(1-kPadding*2-kMutiBoxSize)));
        three.push_back(CGPointMake((1-kPadding-kMutiBoxSize),(1-kPadding*2-kMutiBoxSize)));
        three.push_back(CGPointMake((1-kPadding-kMutiBoxSize)/2,kPadding*3));
        
        offsets = new std::vector<std::vector<CGPoint> >();
        offsets->push_back(one);
        offsets->push_back(three);
    }
    if (images.count == 1) {
        *vt = &(*offsets)[0];
    }else{
        *vt = &(*offsets)[1];
    }
}



@implementation UIImage (Util)

#define teamAvatarCount 3
#define defaultTeamAvatarImage [UIImage imageNamed:@"avatar_defaultempty_icon"]
+ (UIImage *)mergeImagesToBoxStyle: (NSArray *)images {
    
    CGFloat imageSize = 104;
    NSInteger count = [images count];
    NSArray * imageData;
    switch (count) {
        case 0:
            return nil;  //显示默认头像
            break;
        case 1:
            imageData = @[defaultTeamAvatarImage,
                          defaultTeamAvatarImage,
                          [images objectAtIndex:0]];    //顶部显示头像，两侧显示默认头像
            break;
        case 2:
            imageData = @[[images objectAtIndex:1],
                          defaultTeamAvatarImage,
                          [images objectAtIndex:0]];   //顶部，左侧显示头像，右侧显示默认头像
            break;
        case 3:
            imageData = images;
            break;
        default:
            return nil;
    }
    CGFloat size;
    std::vector<CGPoint> *vt = 0;
    CalculateBoxStyle(imageData,size,&vt);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageSize, imageSize),NO,0);
    [[UIColor clearColor] setFill];
    [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, imageSize, imageSize)] fill];
    for (NSInteger i = 0; i < teamAvatarCount; i++)
    {
        CGFloat x       = ((*vt)[i]).x;
        CGFloat y       = ((*vt)[i]).y;
        CGFloat width   = size;
        CGFloat height  = size;
        CGRect avatarBg = CGRectMake(x * imageSize, y * imageSize,
                                     width * imageSize, height * imageSize);
        CGRect avatar     = CGRectInset(avatarBg, 2, 2);
        UIImage *image  = [imageData objectAtIndex:i];
        
        //绘制白色背景
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGPathRef  path = [UIBezierPath bezierPathWithRoundedRect:avatarBg
                                                     cornerRadius:CGRectGetWidth(avatarBg) / 2]. CGPath;
        CGContextAddPath(context, path);
        CGContextClip(context);
        [[UIColor whiteColor] setFill];
        CGContextFillRect(context, avatarBg);
        CGContextRestoreGState(context);
        
        //绘制头像
        CGContextSaveGState(context);
        path = [UIBezierPath bezierPathWithRoundedRect:avatar
                                          cornerRadius:CGRectGetWidth(avatar) / 2]. CGPath;
        CGContextAddPath(context, path);
        CGContextClip(context);
        [image drawInRect:avatar];
        CGContextRestoreGState(context);
        
    }
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSArray *)procesPic:(NSArray *)imgArr {
    
    // UIImage *smallImage=[self scaleFromImage:img toSize:CGSizeMake(120.0f, 120.0f)];//将图片尺寸改为80*80
    NSMutableArray *muarr = [NSMutableArray array];
    if (imgArr.count) {
        for (UIImage *imagee in imgArr) {
            NSData *data = UIImageJPEGRepresentation(imagee,1.0);
            NSString *str = [data base64EncodedString];
            NSString *sendString = (NSString *)
            CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                      (CFStringRef)str,
                                                                      NULL,
                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                      kCFStringEncodingUTF8));
            
            sendString = [sendString stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            
            [muarr addObject:sendString];
        }
    }
    return muarr;
}


@end

