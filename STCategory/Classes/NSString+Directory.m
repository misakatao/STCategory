//
//  NSString+Directory.m
//  CPBaseKit
//
//  Created by MisakaTao on 2018/5/23.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import "NSString+Directory.h"

@implementation NSString (Directory)

- (NSString *)directorySize
{
    // 总大小
    unsigned long long size = 0;
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    BOOL exist = [manager fileExistsAtPath:self isDirectory:&isDir];
    
    // 判断路径是否存在
    if (!exist) return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
    if (isDir) { // 是文件夹
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            NSNumber *fileSize = [manager attributesOfItemAtPath:fullPath error:nil][NSFileSize];
            size += [fileSize unsignedLongLongValue];
        }
    } else { // 是文件
        NSNumber *fileSize = [manager attributesOfItemAtPath:self error:nil][NSFileSize];
        size += [fileSize unsignedLongLongValue];
    }
    return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
}

- (NSString *)docDir
{
    return [[NSString documentPath] stringByAppendingPathComponent:[self lastPathComponent]];
}
- (NSString *)libDir
{
    return [[NSString libraryPath] stringByAppendingPathComponent:[self lastPathComponent]];
}
- (NSString *)cacheDir
{
    return [[NSString cachePath] stringByAppendingPathComponent:[self lastPathComponent]];
}
- (NSString *)homeDir
{
    return [[NSString homePath] stringByAppendingPathComponent:[self lastPathComponent]];
}
- (NSString *)tempDir
{
    return [[NSString tempPath] stringByAppendingPathComponent:[self lastPathComponent]];
}

+ (NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths lastObject];
    return basePath;
}
+ (NSString *)libraryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths lastObject];
    return basePath;
}
+ (NSString *)cachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths lastObject];
    return basePath;
}
+ (NSString *)homePath
{
    return NSHomeDirectory();
}
+ (NSString *)tempPath
{
    return NSTemporaryDirectory();
}

@end
