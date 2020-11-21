//
//  LocaltionTool.m
//  LTXShortVideo
//
//  Created by 白候平 on 2018/12/18.
//  Copyright © 2018 com.xin. All rights reserved.
//

#import "LocaltionTool.h"

@interface LocaltionTool()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationmanager;
@property (nonatomic, strong) void(^locationBlock)(CLLocation *);
@property (nonatomic, strong) void(^placemarkBlock)(CLPlacemark *);
@end

@implementation LocaltionTool

static LocaltionTool * _instance;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_instance == nil){
            _instance = [[self alloc] init];
        }
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        if ([CLLocationManager locationServicesEnabled]) {
            NSLog(@"开始执行定位服务");
            self.locationmanager = [[CLLocationManager alloc]init];
            //2.设置代理
            self.locationmanager.delegate = self;
            //设置定位精度：最佳精度
            self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
            //设置距离过滤器为50米，表示每移动50米更新一次位置
            self.locationmanager.distanceFilter = 50;
            // 注意:在iOS8中, 如果想要追踪用户的位置, 必须自己主动请求隐私权限
            if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
                // 主动请求权限
                [self.locationmanager requestAlwaysAuthorization];
            }
        }else{
            NSLog(@"无法使用定位服务！！！");
        }
    }
    return self;
}

- (void)getPlacemark:(void (^)(CLPlacemark *))placemarkBlock {
    self.placemarkBlock = placemarkBlock;
    //开始监听定位信息
    [self.locationmanager startUpdatingLocation];
}

- (void)getLocation:(void (^)(CLLocation *))locationBlock {
    self.locationBlock = locationBlock;
    //开始监听定位信息
    [self.locationmanager startUpdatingLocation];
}

#pragma mark -- CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if (self.locationBlock) {
        self.locationBlock([locations lastObject]);
        self.locationBlock = nil;
    }
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locations.firstObject completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            if (self.placemarkBlock) {
                self.placemarkBlock([placemarks firstObject]);
                self.placemarkBlock = nil;
            }
            [manager stopUpdatingLocation];
        }
    }];
}

//定位失败时激发的方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败：%@",error);
    [manager stopUpdatingLocation];
}


@end
