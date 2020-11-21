//
//  UILabel+Extension.m
//  kuaidaqiu
//
//  Created by 白候平 on 2017/10/29.
//  Copyright © 2017年 XHH. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

//设置不同字体颜色
- (void)setColorWithText:(NSString *)text andColor:(UIColor *)color andRange:(NSRange)range{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    [string addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = string;
}
//设置不同字体颜色
- (void)setColorWithText:(NSString *)text andFont:(UIFont *)font andColor:(UIColor *)color andRange:(NSRange)range
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    [string addAttribute:NSFontAttributeName value:font range:range];
    [string addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = string;
}
//设置label行间距
-(void)setLineSpacingWithsize:(CGFloat )size andlabelText:(NSString *)text
{
    //调整行间距
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:size];
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [self setAttributedText:string];
//    [self sizeToFit];
}

@end
