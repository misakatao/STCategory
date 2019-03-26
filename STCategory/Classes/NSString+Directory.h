//
//  NSString+Directory.h
//  CPBaseKit
//
//  Created by MisakaTao on 2018/5/23.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Directory)

/* 获取文件大小 */
- (NSString *)directorySize;

/** 生成文档目录全路径 */
- (NSString *)docDir;
/* 生成资源库目录全路径 */
- (NSString *)libDir;
/** 生成缓存目录全路径 */
- (NSString *)cacheDir;
/** 生成主目录全路径 */
- (NSString *)homeDir;
/** 生成临时目录全路径 */
- (NSString *)tempDir;

/* 文档目录 */
+ (NSString *)documentPath;
/* 资源库目录 */
+ (NSString *)libraryPath;
/* 缓存目录 */
+ (NSString *)cachePath;
/* 主目录 */
+ (NSString *)homePath;
/* 临时目录 */
+ (NSString *)tempPath;

@end
