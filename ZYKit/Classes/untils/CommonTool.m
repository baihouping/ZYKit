//
//  CommonTool.m
//  ProjectXmall
//
//  Created by 冷超 on 2017/6/6.
//  Copyright © 2017年 yao liu. All rights reserved.
//

#import "CommonTool.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
@implementation CommonTool
+ (NSString *)networkType {
    NSString *netconnType = @"";
    
    // 获取手机网络类型
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    NSString *currentStatus = info.currentRadioAccessTechnology;
    
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
        
        netconnType = @"GPRS";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
        
        netconnType = @"2.75G EDGE";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
        
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
        
        netconnType = @"3.5G HSDPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
        
        netconnType = @"3.5G HSUPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
        
        netconnType = @"2G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
        
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
        
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
        
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
        
        netconnType = @"HRPD";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
        
        netconnType = @"4G";
    }
    
    return netconnType;
}


+ (NSString *)appBuild {
    return   [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
}

+ (NSString *)appVersion {
    return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)systemVersion {
    return  [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)deviceName {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)timeZone {
    return [NSTimeZone localTimeZone].name;
}

+ (NSString *)country {
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    return  [currentLocale objectForKey:NSLocaleCountryCode];
}

+ (NSString *)language {
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

+ (NSString *)uuid {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(NSString *)displayName{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
}

+(BOOL)isNull:(id)object{
    if(object==nil||object==[NSNull null]){
        return YES;
    }else if([object isKindOfClass:[NSString class]]){
        NSString *string=object;
        if ([string isEqual:@""]||string.length == 0) {
            return YES;
        }
    }else if([object isKindOfClass:[NSData class]]){
        NSData *data=object;
        if (data.length==0) {
            return YES;
        }
    }else if([object isKindOfClass:[NSDictionary class]]){
        NSDictionary *dictionary=object;
        if (dictionary.count==0) {
            return YES;
        }
    }else if([object isKindOfClass:[NSArray class]]){
        NSArray *array=object;
        if (array.count==0) {
            return YES;
        }
    }
    return NO;
}

+ (UIViewController *)topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIViewController *)currentViewController
{
    UIViewController *currentViewController;
    currentViewController = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (currentViewController.presentedViewController) {
        currentViewController = [self topViewController:currentViewController.presentedViewController];
    }
    return currentViewController;
}

+ (BOOL)validateMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
@end
