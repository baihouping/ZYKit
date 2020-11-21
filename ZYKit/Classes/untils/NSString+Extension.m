//
//  NSString+Extension.m
//  kuaidaqiu
//
//  Created by 白候平 on 2017/10/26.
//  Copyright © 2017年 XHH. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>
#import <GTMBase64/GTMBase64.h>
#import "NSDate+Extension.h"

@implementation NSString (Extension)

/**
 根据字体、行数、行间距和constrainedWidth计算文本占据的size
 **/
- (CGSize)textSizeWithFont:(UIFont*)font
             numberOfLines:(NSInteger)numberOfLines
               lineSpacing:(CGFloat)lineSpacing
          constrainedWidth:(CGFloat)constrainedWidth{
    
    if (self.length == 0) {
        return CGSizeZero;
    }
    CGFloat oneLineHeight = font.lineHeight;
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(constrainedWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    //  行数
    CGFloat rows = textSize.height / oneLineHeight;
    CGFloat realHeight = oneLineHeight;
    // 0 不限制行数，真实高度加上行间距
    if (numberOfLines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
        }
    } else {
        //  行数超过指定行数的时候，限制行数
        if (rows > numberOfLines) {
            rows = numberOfLines;
        }
        realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
    }
    //  返回真实的宽高
    return CGSizeMake(constrainedWidth, realHeight);
}

- (CGSize)textSizeWithFont:(UIFont*)font
             numberOfLines:(NSInteger)numberOfLines
          constrainedWidth:(CGFloat)constrainedWidth{
    
    if (self.length == 0) {
        return CGSizeZero;
    }
    CGFloat oneLineHeight = font.lineHeight;
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(constrainedWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    //  行数
    CGFloat rows = textSize.height / oneLineHeight;
    CGFloat realHeight = oneLineHeight;
    // 0 不限制行数，真实高度加上行间距
    if (numberOfLines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneLineHeight) + (rows - 1) ;
        }
    } else {
        //  行数超过指定行数的时候，限制行数
        if (rows > numberOfLines) {
            rows = numberOfLines;
        }
        realHeight = (rows * oneLineHeight) + (rows - 1) ;
    }
    //  返回真实的宽高
    return CGSizeMake(constrainedWidth, realHeight);
}

/// 计算字符串长度（一行时候）
- (CGSize)textSizeWithFont:(UIFont*)font
                limitWidth:(CGFloat)maxWidth {
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 36)options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)  attributes:@{ NSFontAttributeName : font} context:nil].size;
    size.width = size.width > maxWidth ? maxWidth : size.width;
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    return size;
}

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [self sizeWithAttributes:attributes];
    } else {
        textSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    }
    return textSize;
}


+ (NSString *)stringWithNumber:(NSInteger)number {
    if (number <= 1000) {
        return [NSString stringWithFormat:@"%ld",(long)number];
    }else{
        CGFloat newNumber =  number/10000.0;
        NSString *newString = [NSString stringWithFormat:@"%.1f万",newNumber];
        return newString;
    }
}

- (NSString *)trim {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark - 正则匹配
/**
 *  匹配Email
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//是否为银行卡
+ (BOOL)isBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

/**
 *  匹配URL
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isUrl {
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配电话号码
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isTelephone {
    /*
    NSString * MOBILE = @"^1(3[0-9]|47|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";;
    NSString * CU = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    NSString * CT = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:self]   ||
    [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:self]       ||
    [regextestcu evaluateWithObject:self]       ||
    [regextestcm evaluateWithObject:self];
     */
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isMobilephoneNumber{
    if (self == nil) {
        return NO;
    }
    if (self.length == 11 && [self hasPrefix:@"1"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidZipcode {
    const char *cvalue = [self UTF8String];
    
    long len = strlen(cvalue);
    if (len != 6) {
        return NO;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return NO;
        }
    }
    return YES;
}

/**
 *  由英文、字母或数字组成 6-16位
 *
 *  @return YES 验证成功 NO 验证失败
 */
- (BOOL)isPassword {
    NSString * regex = @"^[A-Za-z0-9_]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
    
}

/**
 *  匹配数字
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isNumbers {
    NSString *regEx = @"^-?\\d+.?\\d?";
    NSPredicate *pred= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配英文字母
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isLetter {
    NSString *regEx = @"^[A-Za-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配大写英文字母
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isCapitalLetter {
    NSString *regEx = @"^[A-Z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配小写英文字母
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isSmallLetter {
    NSString *regEx = @"^[a-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配小写英文字母
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isLetterAndNumbers {
    NSString *regEx = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配中文，英文字母和数字及_
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isChineseAndLetterAndNumberAndBelowLine {
    NSString *regEx = @"^[\u4e00-\u9fa5_a-zA-Z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配中文，英文字母和数字及_ 并限制字数
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isChineseAndLetterAndNumberAndBelowLine4to10 {
    NSString *regEx = @"[\u4e00-\u9fa5_a-zA-Z0-9_]{4,10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配含有汉字、数字、字母、下划线不能以下划线开头和结尾
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isChineseAndLetterAndNumberAndBelowLineNotFirstOrLast {
    NSString *regEx = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  最长不得超过7个汉字，或14个字节(数字，字母和下划线)正则表达式
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isBelow7ChineseOrBlow14LetterAndNumberAndBelowLine {
    NSString *regEx = @"^[\u4e00-\u9fa5]{1,7}$|^[\dA-Za-z_]{1,14}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

+ (NSString *)starPhonerNumber:(NSString *)phoneNumber {
    if (phoneNumber.length != 11) {
        return nil;
    }
    return [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 5)  withString:@"*****"];;
}

#pragma mark - 加密
/**
 *  md5加密(32位 常规)
 *
 *  @return 加密后的字符串
 */
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for(int i =0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

/**
 *  md5加密(16位)
 *
 *  @return 加密后的字符串
 */
- (NSString *)md5_16 {
    // 提取32位MD5散列的中间16位
    NSString *md5_32=[self md5];
    // 即9～25位
    NSString *result = [[md5_32 substringToIndex:24] substringFromIndex:8];
    return result;
}

/**
 *  sha1加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)sha1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/**
 *  sha256加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)sha256 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/**
 *  sha384加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)sha384 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/**
 *  sha512加密
 *
 *  @return 加密后的字符串
 */
- (NSString*)sha512 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

/**
 *  base64加密
 *
 *  @return 加密后的字符串
 */
//- (NSString *)base64Encode {
//    NSString *base64String = [GTMBase64 encodeBase64String:self];
//    return base64String;
//}

/**
 *  base64解密
 *
 *  @return 解密后的字符串
 */
//- (NSString *)base64Decode {
//    NSString *base64String = [GTMBase64 decodeBase64String:self];
//    return base64String;
//}

/**
 *  DES加密
 *
 *  @param key 加密需要的key
 *
 *  @return 得到加密后的字符串
 */
- (NSString *)encryptWithKey:(NSString *)key
{
    return [self encrypt:self encryptOrDecrypt:kCCEncrypt key:key];
}

/**
 *  DES解密
 *
 *  @param key 解密需要的key
 *
 *  @return 得到解密后的字符串
 */
- (NSString *)decryptWithKey:(NSString *)key
{
    return [self encrypt:self encryptOrDecrypt:kCCDecrypt key:key];
}

/**
 *  加密或解密
 *
 *  @param sText            需要加密或解密的字符串
 *  @param encryptOperation kCCDecrypt 解密 kCCEncrypt 加密
 *  @param key              加密解密需要的key
 *
 *  @return 返回加密或解密之后得到的字符串
 */
- (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
{
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOperation == kCCDecrypt)
    {
        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [decryptData length];
        vplainText = [decryptData bytes];
    }
    else
    {
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [encryptData length];
        vplainText = (const void *)[encryptData bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    NSString *initVec = @"shuai";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    ccStatus = CCCrypt(encryptOperation,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = nil;
    
    if (encryptOperation == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
    }
    else
    {
        NSData *data = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:data];
    }
    
    return result;
}

#pragma mark - 计算字符串尺寸
/**
 *  计算字符串高度 （多行）
 *
 *  @param width 字符串的宽度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)heightWithWidth:(CGFloat)width andFont:(CGFloat)font {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize  size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin  |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    return size;
}

/**
 *  计算字符串宽度
 *
 *  @param height 字符串的高度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)widthWithHeight:(CGFloat)height andFont:(CGFloat)font {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize  size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)  options:NSStringDrawingUsesLineFragmentOrigin  |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine  attributes:attribute context:nil].size;
    return size;
}

#pragma mark - 富文本
- (NSMutableAttributedString *)UnderlineAttributedStringWithRange:(NSRange )range andColor:(UIColor *)Color{
    NSMutableAttributedString *Attributedstring = [[NSMutableAttributedString alloc] initWithString:self];
    [Attributedstring addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    [Attributedstring addAttribute:NSForegroundColorAttributeName value:Color range:range];
    return Attributedstring;
}
+ (NSMutableAttributedString *)attributeStringWithString:(NSString *)string attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange )range {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttributes:attrs range:range];
    return attString;
}

#pragma mark - 检测是否含有某个字符
/**
 *  检测是否含有某个字符
 *
 *  @param string 检测是否含有的字符
 *
 *  @return YES 含有 NO 不含有
 */
//- (BOOL)containString:(NSString *)string {
//    return ([self rangeOfString:string].location == NSNotFound) ? NO : YES;
//}

/**
 *  是否含有汉字
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)containsChineseCharacter {
    for (int i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 计算String的字数(中英混合)
/**
 *  计算string字数
 *
 *  @return 获得的中英混合字数
 */
- (NSInteger)stringLength {
    NSInteger strlength = 0;
    NSInteger elength = 0;
    for (int i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {
            // 汉字
            strlength++;
        } else {
            // 英文
            elength++;
        }
    }
    return strlength+elength;
}

#pragma mark - 时间戳转换
/**
 *  毫秒级时间戳转日期
 *
 *  @return 日期
 */
- (NSDate *)dateValueWithMillisecondsSince1970 {
    return [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
}

/**
 *  秒级时间戳转日期
 *
 *  @return 日期
 */
- (NSDate *)dateValueWithTimeIntervalSince1970 {
    return [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
}

+ (NSString *)localStringFromUTCDate:(NSDate *)UTCDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:tz];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* result= [dateFormatter stringFromDate:UTCDate];
    return result;
}

+ (NSString *)getNewTimeFromDurationSecond:(NSInteger)duration {
    NSString *newTime;
    if (duration < 10) {
        newTime = [NSString stringWithFormat:@"0:0%zd",duration];
    } else if (duration < 60) {
        newTime = [NSString stringWithFormat:@"0:%zd",duration];
    } else {
        NSInteger min = duration / 60;
        NSInteger sec = duration - (min * 60);
        if (sec < 10) {
            newTime = [NSString stringWithFormat:@"%zd:0%zd",min,sec];
        } else {
            newTime = [NSString stringWithFormat:@"%zd:%zd",min,sec];
        }
    }
    return newTime;
}

#pragma mark - 判断特殊字符
/**
 *  判断字符串是否为空
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)empty {
    return [self length] > 0 ? NO : YES;
}

/**
 *  判断是否为整形
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isInteger {
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

/**
 *  判断是否为浮点形
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  判断是否有特殊字符
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isHasSpecialcharacters {
    NSString *  englishNameRule = @"^[(A-Za-z0-9)*(\u4e00-\u9fa5)*(,|\\.|，|。|\\:|;|：|；|!|！|\\*|\\×|\\(|\\)|\\（|\\）|#|#|\\$|&#|\\$|&|\\^|@|&#|\\$|&|\\^|@|＠|＆|\\￥|\\……)*]+$";
    
    NSPredicate * englishpredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", englishNameRule];
    
    if ([englishpredicate evaluateWithObject:self] == YES) {
        return YES;
    }else{
        return NO;
        
    }
}

/**
 *  判断是否含有数字
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isHasNumder {
    NSString *  englishNameRule = @"[A-Za-z]{2,}|[\u4e00-\u9fa5]{1,}[A-Za-z]+$";
    NSString * chineseNameRule =@"^[\u4e00-\u9fa5]{2,}$";
    
    NSPredicate * englishpredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", englishNameRule];
    NSPredicate *chinesepredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chineseNameRule];
    
    if ([englishpredicate evaluateWithObject:self] == YES||[chinesepredicate evaluateWithObject:self] == YES) {
        return YES;
    }else{
        return NO;
    }
    
}

#pragma mark - 获得特殊字符串
//日期+随机数
/**
 *  日期+随机数的字符串（比如为文件命名）
 *
 *  @return 得到的字符串
 */
+ (NSString*)getTimeAndRandomString {
    
    int iRandom=arc4random();
    if (iRandom<0) {
        iRandom=-iRandom;
    }
    NSDateFormatter *tFormat=[[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *tResult=[NSString stringWithFormat:@"%@%d",[tFormat stringFromDate:[NSDate date]],iRandom];
    return tResult;
}

#pragma mark - json转义
/**
 *  将得到的json的回车替换转义字符
 *
 *  @return 得到替换后的字符串
 */
- (NSString *)changeJsonEnter {
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
}

#pragma mark -  email 转换为 312******@qq.com 形式
- (NSString *)emailChangeToPrivacy {
    
    if (![self isEmail]) {
        return @"";
    }
    
    NSRange range = [self rangeOfString:@"@"];
    
    NSMutableString *changeStr = [NSMutableString stringWithString:self];
    if (range.location > 2) {
        NSRange changeRange;
        changeRange.location = 3;
        changeRange.length = range.location - 3;
        
        NSMutableString *needChanegeToStr = [NSMutableString string];
        for (int i = 0; i < changeRange.length ; i ++) {
            
            [needChanegeToStr appendString:@"*"];
        }
        
        [changeStr replaceCharactersInRange:changeRange withString:needChanegeToStr];
    }
    
    return changeStr;
}
#pragma mark -  mobileNub 转换为 176****1234 形式
- (NSString *)mobileChangeToPrivacy {
    if (self==nil) {
        return @"";
    }
    NSRange range = NSMakeRange(3, 4);
    NSMutableString *changeStr = [NSMutableString stringWithString:self];
    [changeStr replaceCharactersInRange:range withString:@"****"];
    return changeStr;
}

#pragma mark - Emoji相关
/**
 *  判断是否是Emoji
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

/**
 *  判断字符串时候含有Emoji
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isIncludingEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    
    return result;
}

/**
 *  移除掉字符串中得Emoji
 *
 *  @return 得到移除后的Emoji
 */
- (instancetype)removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];
    
    return buffer;
}
/**
 MD5小写加密
 */
+ (NSString *)MD5lowercaseString:(NSString *)str
{
    const char *cStr=[str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result);
    
    NSMutableString *ret=[NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return [ret lowercaseString];
}
/**
 MD5大写加密
 */
+ (NSString *)MD5uppercaseString:(NSString *)str
{
    const char *cStr=[str UTF8String];
    
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result);
    
    
    NSMutableString *ret=[NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return [ret uppercaseString];
}


+ (NSString *)getDayTimer:(NSInteger )timer andtype:(NSString *)str
{
    NSTimeInterval timeinv = timer;
    NSDate *olddate = [NSDate dateWithTimeIntervalSince1970:timeinv];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    if ([str isEqualToString:@"md"]) {
        
        [dateFormatter setDateFormat:@"MM-dd"];
    }else if ([str isEqualToString:@"hm"]) {
        
        [dateFormatter setDateFormat:@"HH:mm"];
    }else if ([str isEqualToString:@"ymdhm"]){
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }else if ([str isEqualToString:@"ymd"]){
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }else{
        [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    }
    NSString *currentDateStr = [dateFormatter stringFromDate:olddate];
    
    return currentDateStr;
}

//传入 秒  得到  xx分钟xx秒
+(NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    return format_time;
}
//获取当前的时间@"YYYY-MM-dd HH:mm:ss"
+(NSString*)getCurrentTimesWithFormat:(NSString *)dateFormat{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];//@"YYYY-MM-dd HH:mm:ss"
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}

//时间转时间戳
+(NSString*)timerToTimestamp:(NSString *)lastTime format:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:format];// @"YYYY-MM-dd HH:mm:ss"
    NSDate *lastDate = [formatter dateFromString:lastTime];
    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    long firstStamp = [lastDate timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%ld",firstStamp];
    return timeString;
}
//时间戳转时间
+(NSString*)timestampToTime:(NSString *)stamp format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:format];// @"YYYY-MM-dd HH:mm:ss"
    NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:stamp.integerValue/1000];
    NSString *timeString = [formatter stringFromDate:stampDate];
    return timeString;
}

//MD5大写加密
+ (NSString *)MD5upper2:(NSString *)str
{
    NSString *sumStr=[NSString stringWithFormat:@"%@%@%@%@",str,str,str,str];
    const char *cStr=[sumStr UTF8String];
    
    unsigned char result[16];
    unsigned char result2[16];
    CC_MD5(cStr, (int)strlen(cStr), result);
    
    CC_MD5(result, 16, result2);
    
    NSMutableString *ret=[NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        
        [ret appendFormat:@"%02X",result2[i]];
    }
    return [ret uppercaseString];
}
+ (NSString *)changeFilesize:(NSInteger )fileSize {
    //将文件夹大小转换为 M/KB/B
    NSString *totleStr = nil;
    
    if (fileSize > 1024 * 1024)
    {
        totleStr = [NSString stringWithFormat:@"%.1fM",fileSize / 1024.0f /1024.0f];
    }else if (fileSize > 1024)
    {
        totleStr = [NSString stringWithFormat:@"%.1fKB",fileSize / 1024.0f ];
        
    }else
    {
        totleStr = [NSString stringWithFormat:@"%.1fB",fileSize / 1.0f];
    }
    
    return totleStr;
}
#pragma mark ---- 字符串nil
+(NSString *)convertNull:(id)obj
{
    if ([obj isEqual:[NSNull null]])
    {
        return @"";
    }else if([obj isKindOfClass:[NSNull class]])
    {
        return @"";
    }else if(obj==nil)
    {
        return @"";
    }
    return obj;
}
//过滤输入表情
+ (BOOL)checkStringContainsEmoji:(NSString *)string{
    if ([self InputRuleNotBlank:string]) {
        return YES;
    }else {
        //不支持系统表情的输入
        if ([self hasEmoji:string]||[self stringContainsEmoji:string] ) {
            return NO;
        }
    }
    return YES;
}
/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
+ (BOOL)hasEmoji:(NSString*)string;
{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
/**
 * 字母、数字、中文正则判断（不包括空格）@"^[a-zA-Z\u4E00-\u9FA5\u278b-\u2792\\d]*$";
 *  @"^[\u278b-\u2792]*$" 9宫格键盘
 */
+ (BOOL)InputRuleNotBlank:(NSString *)string {
    NSString *pattern = @"^[\u4E00-\u9FA5\u278b-\u2792]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    
    return isMatch;
}
-(BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


/**
 *  汉语转拼音
 */
+ (NSString *)getPinYinFromString:(NSString *)string{
    /**
     *  创建可变CFString
     *
     *   NULL 使用默认创建器
     *   0    长度不限制
     *   "张三" cf字串
     *   可变字符串
     */
    CFMutableStringRef aCstring = CFStringCreateMutableCopy(NULL, 0, (__bridge_retained CFStringRef)string);
    
    /**
     *  1. string: 要转换的字符串(可变的)
     2. range: 要转换的范围 NULL全转换
     3. transform: 指定要怎样的转换
     4. reverse: 是否可逆的转换
     */
    CFStringTransform(aCstring, NULL, kCFStringTransformMandarinLatin, NO);
    
    CFStringTransform(aCstring, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [NSString stringWithFormat:@"%@",aCstring];
}

/**
 对象转json字符串
 */
+ (NSString *)toJSONString:(id)object {
    NSData *data = [NSJSONSerialization dataWithJSONObject:object
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data==nil) {
        return nil;
    }
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}


+(NSString *)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

@end
