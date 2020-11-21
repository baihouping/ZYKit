//
//  UIBarButtonItem+Item.h
//  BuDeJie
//
//  Created by DJR on 16/8/26.
//  Copyright © 2016年 DJR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;


+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;


+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action color:(UIColor *)color title:(NSString *)title fontSize:(CGFloat)fontSize;

@end
