//
//  UIApplication+Extension.h
//  CPBaseKit
//
//  Created by MisakaTao on 2018/5/23.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Extension)

/**
 *  统计应用文件大小
 *
 *  @return 大小
 */
- (NSString *)applicationSize;
/**
 *  计算文件夹大小
 *
 *  @param folderPath 文件夹路径
 *
 *  @return 大小
 */
- (unsigned long long)sizeOfFolder:(NSString *)folderPath;

/* app的版本号 */
+ (NSString *)appVersion;
/* app build版本号 */
+ (NSString *)buildVersion;
/* app的显示名称 */
+ (NSString *)displayName;
/* app的identifier */
+ (NSString *)bundleIdentifier;
/* 获取当前语言 */
+ (NSString *)localeLanguage;

@end
