//
//  UIImage+Extension.h
//  kuaidaqiu
//
//  Created by 白候平 on 2017/11/1.
//  Copyright © 2017年 XHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
// 根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
// 改变图像的尺寸，方便上传服务器
+ (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size;
//保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;
// 获取原型边框图片
+ (instancetype)imageWithIconName:(UIImage *)image borderImage:(UIImage *)borderImg border:(int)border;
//等比率缩放
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
//自定长宽
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
/**
 *  带边框的图片
 *
 *  @param image   图片名
 *  @param imageWidth  图片宽度
 *  @param imageHeight 图片高度
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 带边框的图片
 */
+(UIImage *)imageWithImageName:(UIImage *)image imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
