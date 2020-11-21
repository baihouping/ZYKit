//
//  UITextField+XHTextField.h
//  DataDynamics
//
//  Created by 白候平 on 2018/7/11.
//  Copyright © 2018年 com.xin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (XHTextField)
+ (UITextField *)textFieldWithFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                      placeHolderColor:(UIColor *)placeHolderColor
                           placeHolder:(NSString*)placeHolder;
@end
