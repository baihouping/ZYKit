//
//  NSString+Extension.h
//  kuaidaqiu
//
//  Created by 白候平 on 2017/10/26.
//  Copyright © 2017年 XHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 根据字体、行数、行间距和指定的宽度constrainedWidth计算文本占据的size
 @param font 字体
 @param numberOfLines 显示文本行数，值为0不限制行数
 @param lineSpacing 行间距
 @param constrainedWidth 文本指定的宽度
 @return 返回文本占据的size
 */
- (CGSize)textSizeWithFont:(UIFont*)font
             numberOfLines:(NSInteger)numberOfLines
               lineSpacing:(CGFloat)lineSpacing
          constrainedWidth:(CGFloat)constrainedWidth;

/**
 根据字体、行数、行间距和指定的宽度constrainedWidth计算文本占据的size
 @param font 字体
 @param numberOfLines 显示文本行数，值为0不限制行数
 @param constrainedWidth 文本指定的宽度
 @return 返回文本占据的size
 */
- (CGSize)textSizeWithFont:(UIFont*)font
             numberOfLines:(NSInteger)numberOfLines
          constrainedWidth:(CGFloat)constrainedWidth;

/// 计算字符串长度（一行时候）
- (CGSize)textSizeWithFont:(UIFont*)font
                limitWidth:(CGFloat)maxWidth;

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
#pragma mark - 数字转换为万

+ (NSString *)stringWithNumber:(NSInteger)number;

#pragma mark - 去空格
- (NSString *)trim;

#pragma mark - 判断特殊字符
- (BOOL)empty;
- (BOOL)isInteger;
- (BOOL)isFloat;
- (BOOL)isHasSpecialcharacters;
- (BOOL)isHasNumder;

#pragma mark - 时间戳转换
- (NSDate *)dateValueWithMillisecondsSince1970;
- (NSDate *)dateValueWithTimeIntervalSince1970;
+ (NSString *)localStringFromUTCDate:(NSDate *)UTCDate;
#pragma 计算字数(中英混合 都算一个)
- (NSInteger)stringLength;

#pragma mark - 计算是否含有
//- (BOOL)containString:(NSString *)string;
- (BOOL)containsChineseCharacter;

#pragma mark - 计算字符串尺寸
- (CGSize)heightWithWidth:(CGFloat)width andFont:(CGFloat)font;
- (CGSize)widthWithHeight:(CGFloat)height andFont:(CGFloat)font;

#pragma mark - 富文本
- (NSMutableAttributedString *)UnderlineAttributedStringWithRange:(NSRange )range andColor:(UIColor *)Color;
+ (NSMutableAttributedString *)attributeStringWithString:(NSString *)string attributes:(NSDictionary*)attrs range:(NSRange )range;

#pragma mark - 正则匹配
- (BOOL)isEmail;
+ (BOOL)isBankCard:(NSString *)cardNumber;
- (BOOL)isUrl;
- (BOOL)isTelephone;
- (BOOL)isValidZipcode;
- (BOOL)isPassword;
- (BOOL)isMobilephoneNumber;

- (BOOL)isNumbers;
- (BOOL)isLetter;
- (BOOL)isCapitalLetter;
- (BOOL)isSmallLetter;
- (BOOL)isLetterAndNumbers;
- (BOOL)isChineseAndLetterAndNumberAndBelowLine;
- (BOOL)isChineseAndLetterAndNumberAndBelowLine4to10;
- (BOOL)isChineseAndLetterAndNumberAndBelowLineNotFirstOrLast;
- (BOOL)isBelow7ChineseOrBlow14LetterAndNumberAndBelowLine;
//手机号中间变成****
+ (NSString *)starPhonerNumber:(NSString *)phoneNumber;

#pragma mark - 加密
// md5
- (NSString*)md5;

// sha
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString *)sha384;
- (NSString *)sha512;

// base64
//- (NSString *)base64Encode;
//- (NSString *)base64Decode;

// des
- (NSString *)encryptWithKey:(NSString *)key;
- (NSString *)decryptWithKey:(NSString *)key;

#pragma mark - 获得特殊字符串
+ (NSString*)getTimeAndRandomString;

#pragma mark - json转义
- (NSString *)changeJsonEnter;
#pragma mark -  email 转换为 312******@qq.com 形式
- (NSString *)emailChangeToPrivacy;
#pragma mark -  mobileNub 转换为 176****1234 形式
- (NSString *)mobileChangeToPrivacy;
#pragma mark - Emoji
- (BOOL)isIncludingEmoji;
- (instancetype)removedEmojiString;

+ (NSString *)MD5uppercaseString:(NSString *)str;

#pragma mark ---- 时间
+(NSString *)getNowTimeTimestamp;
+ (NSString *)getDayTimer:(NSInteger )timer andtype:(NSString *)str;
//传入 秒  得到  xx分钟xx秒
+(NSString *)getMMSSFromSS:(NSString *)totalTime;
//获取当前的时间@"YYYY-MM-dd HH:mm:ss"
+(NSString*)getCurrentTimesWithFormat:(NSString *)dateFormat;
//时间转时间戳
+(NSString*)timerToTimestamp:(NSString *)lastTime format:(NSString *)format ;
//时间戳转时间
+(NSString*)timestampToTime:(NSString *)stamp format:(NSString *)format;
+ (NSString *)getNewTimeFromDurationSecond:(NSInteger)duration;

//MD5大写加密
+ (NSString *)MD5upper2:(NSString *)str;
+ (NSString *)changeFilesize:(NSInteger )fileSize;
#pragma mark ---- 字符串nil
+(NSString *)convertNull:(id)obj;

//过滤输入表情
+ (BOOL)checkStringContainsEmoji:(NSString *)string;
/**
 *  汉语转拼音
 */
+ (NSString *)getPinYinFromString:(NSString *)string;
/**
 对象转json字符串
 */
+ (NSString *)toJSONString:(id)object;

@end
