//
//  NSDate+Extension.m
//  kuaidaqiu
//
//  Created by 白候平 on 2017/11/8.
//  Copyright © 2017年 XHH. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

// 获取当前时间戳
+ (NSString *)getCurrentTimestamp {
    //当前时间时间戳
    NSDate *nowDate = [NSDate date];
    NSTimeInterval interval = [nowDate timeIntervalSince1970];
    //转为字符型毫秒级的
    NSString *timeString = [NSString stringWithFormat:@"%.0f000", interval];
    return timeString;
}
//获取当前时间
+ (NSString *)getCurrentDate:(NSString *)dategs {
    //当前时间时间戳
    NSDate * now = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dategs];
    NSString *datestr=[formatter stringFromDate:now];
    return datestr;
}
//获取时间戳的差值 返回的是秒数
+ (NSInteger)getTimestampDifferenceValue:(NSString *)leaveTimestamp comebackTimestamp:(NSString *)comebackTimestamp {
    
    NSInteger leave_Timestamp = [leaveTimestamp integerValue];
    NSInteger comeback_Timestamp = [comebackTimestamp integerValue];
    NSInteger cha = comeback_Timestamp - leave_Timestamp;
    
    return cha;
}

//获取当地时间
+ (NSString *)getCurrentTimeYMD {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss:SSS"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
//获取当地时间YMDHM
+ (NSString *)getCurrentTimeYMDHM {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
+(NSString *)getNowTimeTimestamp {
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

#pragma mark -- 获取日
- (NSInteger)day:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)fromDate:date];
    return components.day;
}

#pragma mark -- 获取月
- (NSInteger)month:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)fromDate:date];
    return components.month;
}

#pragma mark -- 获取年
- (NSInteger)year:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)fromDate:date];
    return components.year;
}

- (NSString *)weakDay:(NSDate *)date {
    //获取日期
    NSArray *arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",nil];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //设置时区
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ZH_cn"];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    return [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:([comps weekday] - 1)]];
}

#pragma mark -- 获得当前月份第一天星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置每周的第一天从周几开始,默认为1,从周日开始
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    //若设置从周日开始算起则需要减一,若从周一开始算起则不需要减
    return firstWeekday -1;
}
#pragma mark -- 获取当前月共有多少天

- (NSInteger)totaldaysInMonth:(NSDate *)date {
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}
//时间转时间戳
+ (NSString *)timeChangeTimestampFormat:(NSString *)Format time:(NSString *)lastTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:Format];//@"YYYY-MM-dd HH:mm:ss"
    NSDate *lastDate = [formatter dateFromString:lastTime];
    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)([lastDate timeIntervalSince1970]*1000)];
    return timeStamp;
}

@end
