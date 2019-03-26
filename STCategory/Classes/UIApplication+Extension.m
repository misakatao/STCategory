//
//  UIApplication+Extension.m
//  CPBaseKit
//
//  Created by MisakaTao on 2018/5/23.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import "UIApplication+Extension.h"
#import "NSString+Directory.h"

@implementation UIApplication (Extension)

/**
 *  统计应用文件大小
 *
 *  @return 大小
 */
- (NSString *)applicationSize {
    
    unsigned long long docSize   =  [self sizeOfFolder:[NSString documentPath]];
    unsigned long long libSize   =  [self sizeOfFolder:[NSString libraryPath]];
    unsigned long long cacheSize =  [self sizeOfFolder:[NSString cachePath]];
    
    unsigned long long total = docSize + libSize + cacheSize;
    
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:total countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}

/**
 *  计算文件夹大小
 *
 *  @param folderPath 文件夹路径
 *
 *  @return 大小
 */
- (unsigned long long)sizeOfFolder:(NSString *)folderPath {
    
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    unsigned long long folderSize = 0;
    // 遍历文件夹
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    return folderSize;
}


+ (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+ (NSString *)buildVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
+ (NSString *)displayName
{
    return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
}
+ (NSString *)bundleIdentifier
{
    return [[NSBundle mainBundle] bundleIdentifier];
}
+ (NSString *)localeLanguage
{
    return [[NSLocale preferredLanguages] firstObject];
}


@end
