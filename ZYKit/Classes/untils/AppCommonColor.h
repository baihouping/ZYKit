//
//  AppCommonColor.h
//  winnowerLife
//
//  Created by 白候平 on 2019/5/5.
//  Copyright © 2019 白候平. All rights reserved.
//

#ifndef AppCommonColor_h
#define AppCommonColor_h


//颜色相关
#define THEME_COLOR              [UIColor colorWithHexString:@"f05253"]
#define THEMEBG_COLOR            [UIColor colorWithHexString:@"929292"]
#define STRING_COLOR(string)     [UIColor colorWithHexString:@#string]
#define RGBA(r, g, b, a)         [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
#define RGB(r, g, b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RANDOM_COLOR        [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]


#endif /* AppCommonColor_h */
