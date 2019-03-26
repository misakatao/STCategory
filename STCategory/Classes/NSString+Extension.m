//
//  NSString+Extension.m
//  CPBaseKit
//
//  Created by MisakaTao on 2017/3/7.
//  Copyright © 2017年 misakatao. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Extension)

- (NSString *)fileSizeString
{
    // 总大小
    unsigned long long size = 0;
    // 文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    // 文件属性
    NSDictionary *attrs = [manager attributesOfItemAtPath:self error:nil];
    // 如果这个文件或者文件夹不存在,或者路径不正确直接返回0;
    if (attrs == nil) return [NSString stringWithFormat:@"%llu", size];
    
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 如果是文件夹
        // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 文件大小
            NSNumber *fileSize = [manager attributesOfItemAtPath:fullSubpath error:nil][NSFileSize];
            // 累加文件大小
            size += fileSize.unsignedLongLongValue;
        }
        return [NSString sizeStringWith:size];
        
    } else { // 如果是文件
        size = [attrs[NSFileSize] unsignedLongLongValue];
        
        return [NSString sizeStringWith:size];
    }
}

+ (NSString *)sizeStringWith:(unsigned long long)fileSize
{
    NSString *sizeString;
    
    if (fileSize >= pow(10, 9)) { // size >= 1GB
        sizeString = [NSString stringWithFormat:@"%.2fGB", fileSize / pow(10, 9)];
    } else if (fileSize >= pow(10, 6)) { // 1GB > size >= 1MB
        sizeString = [NSString stringWithFormat:@"%.2fMB", fileSize / pow(10, 6)];
    } else if (fileSize >= pow(10, 3)) { // 1MB > size >= 1KB
        sizeString = [NSString stringWithFormat:@"%.2fKB", fileSize / pow(10, 3)];
    } else { // 1KB > size
        sizeString = [NSString stringWithFormat:@"%zdB", fileSize];
    }
    
    return sizeString;
}

- (CompareResultType)versionCompare:(NSString *)oldVersion
{
    NSArray *currentVersionArray = [self componentsSeparatedByString:@"."];
    NSArray *oldVersionArray = [oldVersion componentsSeparatedByString:@"."];
    
    NSInteger currentVersionLength = currentVersionArray.count;
    NSInteger oldVersionLength = oldVersionArray.count;
    
    // 小数点个数不相等，按下标索引从小到大比较，若较小的位数都相同，那么较大位数的大（1.1.1 > 1.1）
    if (currentVersionLength != oldVersionLength) {
        NSInteger smallerLength = currentVersionLength < oldVersionLength ? currentVersionLength : oldVersionLength;
        for (int i = 0; i < smallerLength; i++) {
            if ([currentVersionArray[i] intValue] < [oldVersionArray[i] intValue]) {
                return SmallerResultType;
            } else if ([currentVersionArray[i] intValue] > [oldVersionArray[i] intValue]) {
                return BiggerResultType;
            } else {
                continue; //相等就继续
            }
        }
        //前面的都相等, （1.1.1 > 1.1）
        return currentVersionLength < oldVersionLength ? SmallerResultType : BiggerResultType;
    } else {
        //小数点个数相等，按下标索引从小到大比较
        for (int i = 0; i < currentVersionLength; i++) {
            if ([currentVersionArray[i] intValue] < [oldVersionArray[i] intValue]) {
                return SmallerResultType;
            } else if ([currentVersionArray[i] intValue] > [oldVersionArray[i] intValue]) {
                return BiggerResultType;
            } else {
                continue; //相等就继续
            }
        }
    }
    return EqualResultType;
}

- (CGSize)sizeWithFont:(UIFont *)font constraineSize:(CGSize)size
{
    CGSize textSize;
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        
        textSize = [self sizeWithAttributes:attributes];
        
    } else {
        // NSStringDrawingTruncatesLastVisibleLine 内容超出指定的矩形限制，将被截去并在最后一个字符后加上省略号。
        // NSStringDrawingUsesLineFragmentOrigin 该选项被忽略
        // NSStringDrawingUsesFontLeading 计算行高时使用行间距。（字体大小+行间距=行高）
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
    }
    return textSize;
}

- (CGSize)sizeFromFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode
{
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attributes[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attributes context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font
{
    CGSize size = [self sizeFromFont:font size:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = [self sizeFromFont:font size:CGSizeMake(width, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping];
    return size.height;
}


+ (NSString *)strmethodComma:(NSString *)str
{
    NSString *intStr;
    NSString *floStr;
    
    if ([str containsString:@"."]) {
        NSRange range = [str rangeOfString:@"."];
        floStr = [str substringFromIndex:range.location];
        intStr = [str substringToIndex:range.location];
        
    } else {
        floStr = @"";
        intStr = str;
    }
    
    if (intStr.length <=3 ) {
        return [intStr stringByAppendingString:floStr];
        
    } else {
        NSInteger length = intStr.length;
        NSInteger count = length/3;
        NSInteger y = length % 3;
        NSString *tit = [intStr substringToIndex:y];
        
        NSMutableString *det = [[intStr substringFromIndex:y] mutableCopy];
        
        for (int i = 0; i < count; i++) {
            NSInteger index = i + i * 3;
            [det insertString:@","atIndex:index];
        }
        if (y == 0) {
            det = [[det substringFromIndex:1] mutableCopy];
        }
        
        intStr = [tit stringByAppendingString:det];
        return [intStr stringByAppendingString:floStr];
    }
}

/**
 时间戳 转 正常时间显示
 
 @param timeString 时间戳
 @return 正常时间显示
 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString andDateFormat:(NSString*)dateFormat
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormat];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


#pragma mark - 时间戳转显示String 方法

/**
 HH:mm
 */
+ (NSString *)timeIntervalHHmm:(NSString *)timeString {
    return [self timeWithTimeIntervalString:timeString andDateFormat:@"HH:mm"];
}


/**
 M-dd HH:mm
 */
+ (NSString *)timeIntervalMddHHmm:(NSString *)timeString {
    return [self timeWithTimeIntervalString:timeString andDateFormat:@"M-dd HH:mm"];
}

/**
 HH:mm:ss
 */
+ (NSString *)timeIntervalHHmmss:(NSString *)timeString {
    return [self timeWithTimeIntervalString:timeString andDateFormat:@"HH:mm:ss"];
}


#pragma mark - 时间对比

/**
 时间间隔 - 返回具体显示文字
 
 @param timeA 记录的时间
 @return 刚刚／x分钟前 ／ x小时前 ／ x 月先 ／ x 年前
 */
+ (NSString*)timeDistanceFirstTime:(NSString*)timeA {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:timeA];//model.created_at 时间
    //八小时时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:timeDate];
    NSDate *mydate = [timeDate dateByAddingTimeInterval:interval];
    NSDate *nowDate = [[NSDate date]dateByAddingTimeInterval:interval];
    //两个时间间隔
    NSTimeInterval timeInterval = [mydate timeIntervalSinceDate:nowDate];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *timeLabelText;
    if (timeInterval<60) {
        timeLabelText = [NSString stringWithFormat:@"刚刚"];
    }else if ((temp = timeInterval/60)<60){
        timeLabelText = [NSString stringWithFormat:@"%ld分钟前",temp];
    }else if ((temp = timeInterval/(60*60))<24){
        timeLabelText = [NSString stringWithFormat:@"%ld小时前",temp];
    }else if((temp = timeInterval/(24*60*60))<30){
        timeLabelText = [NSString stringWithFormat:@"%ld天前",temp];
    }else if (((temp = timeInterval/(24*60*60*30)))<12){
        timeLabelText = [NSString stringWithFormat:@"%ld月前",temp];
    }else {
        temp = timeInterval/(24*60*60*30*12);
        timeLabelText = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return timeLabelText;
}


/**
 
 时间间隔 - 间隔 integer
 
 @param timeA 记录的时间
 @return 返回具体显示文字
 */
+ (NSTimeInterval)timeDistancTimeInterval:(NSString *)timeA {
    
    //from time
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:[timeA doubleValue]];
    
    //八小时时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:timeDate];
    NSDate *mydate = [timeDate dateByAddingTimeInterval:interval];
    
    NSDate *nowDate = [[NSDate date]dateByAddingTimeInterval:interval];
    //两个时间间隔
    NSTimeInterval timeInterval = [mydate timeIntervalSinceDate:nowDate];
    timeInterval = -timeInterval;
    
    return timeInterval;
}


#pragma mark - Contains
/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)isContainChinese
{
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)isContainBlank
{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

//Unicode编码的字符串转成NSString
- (NSString *)makeUnicodeToString
{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

- (BOOL)containsCharacterSet:(NSCharacterSet *)set
{
    NSRange rang = [self rangeOfCharacterFromSet:set];
    if (rang.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

/**
 *  @brief 获取字符数量
 */
- (int)wordsCount
{
    NSInteger n = self.length;
    int i;
    int l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++)
    {
        c = [self characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a == 0 && l == 0) {
        return 0;
    }
    return l + (int)ceilf((float)(a + b) / 2.0);
}

//--------------------------- 【正则表达式】 ------------------------------//
//

- (BOOL)match:(NSString *)pattern
{
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

// QQ号验证
- (BOOL)isQQ
{
    // 1.不能以0开头
    // 2.全部是数字
    // 3.5-11位
    return [self match:@"^[1-9]\\d{4,10}$"];
}

// 手机号验证
- (BOOL)isPhoneNumber
{
    NSString *string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (string.length != 11) {
        return NO;
    }
    // 1.全部是数字
    // 2.11位
    // 3.以13\15\18\17开头
    // JavaScript的正则表达式:\^1[3578]\\d{9}$\
    
    return [self match:@"^[1][3,4,5,6,7,8][0-9]{9}$"];
}


//邮箱
- (BOOL)isEmail
{
    return [self match:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

//身份证号
- (BOOL)isIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    return [self match:@"^(\\d{14}|\\d{17})(\\d|[xX])$"];
}

// 网址验证
- (BOOL)isIPAddress
{
    // 1-3个数字: 0-255
    // 1-3个数字.1-3个数字.1-3个数字.1-3个数字
    return [self match:@"^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$"];
}

// 车牌号验证
- (BOOL)isDateCarNo
{
    return [self match:@"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$"];
}


#pragma mark - Hash

- (NSString *)md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH].lowercaseString;
}

- (NSString *)sha1String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha224String {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA224(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha256String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha384String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA384(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha512String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)hmacMD5StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgMD5 withKey:key];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

- (NSString *)hmacSHA224StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

- (NSString *)hmacSHA384StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key
{
    return [self hmacStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
}


#pragma mark - Helpers

- (NSString *)hmacStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key
{
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:size];
    CCHmac(alg, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:(int)mutableData.length];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}



@end
