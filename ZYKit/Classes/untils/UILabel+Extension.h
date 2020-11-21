//
//  UILabel+Extension.h
//  kuaidaqiu
//
//  Created by 白候平 on 2017/10/29.
//  Copyright © 2017年 XHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
//设置不同字体颜色
- (void)setColorWithText:(NSString *)text andColor:(UIColor *)color andRange:(NSRange)range;
//设置不同字体颜色
- (void)setColorWithText:(NSString *)text andFont:(UIFont *)font andColor:(UIColor *)color andRange:(NSRange)range;
//设置label行间距
-(void)setLineSpacingWithsize:(CGFloat )size andlabelText:(NSString *)text;

@end
