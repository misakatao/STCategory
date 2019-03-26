//
//  NSString+Extension.h
//  CPBaseKit
//
//  Created by MisakaTao on 2017/3/7.
//  Copyright © 2017年 misakatao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CompareResultType) {
    BiggerResultType,
    SmallerResultType,
    EqualResultType,
};

@interface NSString (Extension)

/* 获取文件大小 */
- (NSString *)fileSizeString;

/* 获取文件大小 */
+ (NSString *)sizeStringWith:(unsigned long long)fileSize;


/* 版本号比较 */
- (CompareResultType)versionCompare:(NSString *)oldVersion;

/* 字符串尺寸 */
- (CGSize)sizeWithFont:(UIFont *)font constraineSize:(CGSize)size;
/* 字符串尺寸 */
- (CGSize)sizeFromFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/* 字符串宽度 */
- (CGFloat)widthForFont:(UIFont *)font;

/* 字符串高度 */
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

/* 价格格式化 */
+ (NSString *)strmethodComma:(NSString *)str;

+ (NSString *)timeIntervalHHmm:(NSString *)timeString;
+ (NSString *)timeIntervalMddHHmm:(NSString *)timeString;
+ (NSString *)timeIntervalHHmmss:(NSString *)timeString;

+ (NSString *)timeDistanceFirstTime:(NSString*)timeA;
+ (NSTimeInterval)timeDistancTimeInterval:(NSString *)timeA;


#pragma mark - Contains
/**
 *  @return URL是否包含中文
 */
- (BOOL)isContainChinese;
/**
 *  @return 是否包含空格
 */
- (BOOL)isContainBlank;
/**
 *  @return Unicode编码的字符串转成NSString
 */
- (NSString *)makeUnicodeToString;
/**
 *  @brief 是否包含字符集
 */
- (BOOL)containsCharacterSet:(NSCharacterSet *)set;
/**
 *  @brief 获取字符数量
 */
- (int)wordsCount;

//--------------------------- 【正则表达式】 ------------------------------//
//
- (BOOL)isQQ;
- (BOOL)isPhoneNumber;
- (BOOL)isEmail;
- (BOOL)isIdentityCard;
- (BOOL)isIPAddress;
- (BOOL)isDateCarNo;


#pragma mark - Hash
/// 返回结果：32长度(128位，16字节，16进制字符输出则为32字节长度)   终端命令：md5 -s "123"
@property (readonly) NSString *md5String;
/// 返回结果：40长度   终端命令：echo -n "123" | openssl sha -sha1
@property (readonly) NSString *sha1String;
/// 返回结果：56长度   终端命令：echo -n "123" | openssl sha -sha224
@property (readonly) NSString *sha224String;
/// 返回结果：64长度   终端命令：echo -n "123" | openssl sha -sha256
@property (readonly) NSString *sha256String;
/// 返回结果：96长度   终端命令：echo -n "123" | openssl sha -sha384
@property (readonly) NSString *sha384String;
/// 返回结果：128长度   终端命令：echo -n "123" | openssl sha -sha512
@property (readonly) NSString *sha512String;


#pragma mark - HMAC
/// 返回结果：32长度  终端命令：echo -n "123" | openssl dgst -md5 -hmac "123"
- (NSString *)hmacMD5StringWithKey:(NSString *)key;
/// 返回结果：40长度   echo -n "123" | openssl sha -sha1 -hmac "123"
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)hmacSHA224StringWithKey:(NSString *)key;
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)hmacSHA384StringWithKey:(NSString *)key;
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;


@end


