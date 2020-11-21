//
//  UIView+Extension.m
//  XHH
//
//  Created by 白候平 on 15/7/6.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(CGFloat)centerX
{

    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

+(UIView *)getViewWithBgColorHex:(NSString *)colorHex{
    UIView *view = [[UIView alloc] init];
    if (colorHex) {
        view.backgroundColor = [UIColor colorWithHexString:colorHex];
    }
    return view;
}

+(UIButton *)getButtonWithFontSize:(UIFont *)font textColorHex:(NSString *)colorHex backgroundColor:(NSString *)color
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (font) {
        btn.titleLabel.font = font;
    }
    
    if (colorHex) {
        [btn setTitleColor:[UIColor colorWithHexString:colorHex] forState:UIControlStateNormal];
    }
    
    if (color) {
        [btn setBackgroundColor:[UIColor colorWithHexString:color]];
    }
    
    return btn;
}

+(UIImageView *)getImageViewWithImageName:(NSString *)imageName
{
    UIImageView *imageView;
    if (!imageName || [imageName isEqualToString:@""]) {
        imageView = [[UIImageView alloc] init];
    } else {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    }
    return imageView;
}

+(UILabel *)getLabelWithFontSize:(UIFont *)font textColorHex:(NSString *)colorHex{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = [UIColor colorWithHexString:colorHex];
    return label;
}

+(UITextField *)getTextFieldWithFontSize:(UIFont *)font textColorHex:(NSString *)colorHex placeHolder:(NSString *)placeHolder{
    UITextField *textfield = [[UITextField alloc] init];
    textfield.font = font;
    textfield.textColor = [UIColor colorWithHexString:colorHex];
    textfield.placeholder = placeHolder;
    return textfield;
}


@end
