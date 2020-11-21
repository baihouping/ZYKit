//
//  UITextField+XHTextField.m
//  DataDynamics
//
//  Created by 白候平 on 2018/7/11.
//  Copyright © 2018年 com.xin. All rights reserved.
//

#import "UITextField+XHTextField.h"

@implementation UITextField (XHTextField)

+ (UITextField *)textFieldWithFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                      placeHolderColor:(UIColor *)placeHolderColor
                           placeHolder:(NSString*)placeHolder
{
    UITextField *textField = [UITextField new];
    if (fontSize>0) {
        textField.font = [UIFont systemFontOfSize:fontSize];
    }
    textField.textColor = textColor;
    textField.placeholder = placeHolder;
    [textField setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    return textField;
}

@end
