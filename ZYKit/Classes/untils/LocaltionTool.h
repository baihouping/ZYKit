//
//  LocaltionTool.h
//  LTXShortVideo
//
//  Created by 白候平 on 2018/12/18.
//  Copyright © 2018 com.xin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocaltionTool : NSObject

+ (instancetype)shareManager;

//获取经纬度
- (void)getPlacemark:(void (^)(CLPlacemark *))placemarkBlock;

//获取地理信息
- (void)getLocation:(void (^)(CLLocation *))locationBlock;

@end

NS_ASSUME_NONNULL_END
