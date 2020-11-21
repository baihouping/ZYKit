//
//  WLBaseViewModel.h
//  winnowerLife
//
//  Created by 白候平 on 2019/6/4.
//  Copyright © 2019 白候平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HTTPRequestStatus) {
    HTTPRequestStatusBegin,
    HTTPRequestStatusEnd,
    HTTPRequestStatusError,
};

@interface WLBaseViewModel : NSObject

@end

NS_ASSUME_NONNULL_END
