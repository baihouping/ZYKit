//
//  UIView+Extension.h
//  XHH
//
//  Created by 白候平 on 15/7/6.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
/**
 *  实例化一个UIView，省去每次都要写很多重复的代码
 *
 *  @param colorHex  颜色
 *
 *  @return UILabel
 */
+(UIView *)getViewWithBgColorHex:(NSString *)colorHex;

/**
 *  获取一个button
 *
 *  @param font             title的font
 *  @param colorHex         title的色值
 *  @param color            背景色
 *
 *  @return UIButton
 */
+(UIButton *)getButtonWithFontSize:(UIFont *)font textColorHex:(NSString *)colorHex backgroundColor:(NSString *)color;

/**
 *  实例化一个UIImageView
 *
 *  @param imageName 图片名
 *
 *  @return UIImageView
 */
+(UIImageView *)getImageViewWithImageName:(NSString *)imageName;

/**
 *  实例化一个UILabel
 *
 *  @param font         fontsize
 *  @param colorHex     color
 *  @return UILabel
 */
+(UILabel *)getLabelWithFontSize:(UIFont *)font textColorHex:(NSString *)colorHex;


/**
 实例化一个UITextfield
 
 @param font 字体
 @param colorHex 字体颜色
 @param placeHolder 水印
 @return UITextfield
 */
+(UITextField *)getTextFieldWithFontSize:(UIFont *)font textColorHex:(NSString *)colorHex placeHolder:(NSString *)placeHolder;
@end
