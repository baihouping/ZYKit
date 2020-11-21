//
//  NSDate+Extension.h
//  kuaidaqiu
//
//  Created by 白候平 on 2017/11/8.
//  Copyright © 2017年 XHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

//获取当前时间戳
+ (NSString *)getCurrentTimestamp;
//获取当前时间
+ (NSString *)getCurrentDate:(NSString *)dategs;
//获取时间戳的差值 返回的是秒数
+ (NSInteger)getTimestampDifferenceValue:(NSString *)leaveTimestamp comebackTimestamp:(NSString *)comebackTimestamp;
//获取当地时间
+ (NSString *)getCurrentTimeYMD;
//获取当地时间YMDHM
+ (NSString *)getCurrentTimeYMDHM;
// 获取当前时间戳
+(NSString *)getNowTimeTimestamp;


#pragma mark - 获取日
- (NSInteger)day:(NSDate *)date;
#pragma mark - 获取月
- (NSInteger)month:(NSDate *)date;
#pragma mark - 获取年
- (NSInteger)year:(NSDate *)date;
#pragma mark - 获取当月第一天周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
#pragma mark - 获取当前月有多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date;
#pragma mark - 获取星期几
- (NSString *)weakDay:(NSDate *)date;
//时间转时间戳
+ (NSString *)timeChangeTimestampFormat:(NSString *)Format time:(NSString *)lastTime;

@end
