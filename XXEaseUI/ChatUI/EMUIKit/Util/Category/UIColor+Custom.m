//
//  UIColor+Custom.m
//  XXEaseUI
//
//  Created by xiucheren on 16/10/13.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)
+(UIColor *)red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    return [[UIColor alloc] initWithRed:red/255 green:green/255 blue:blue/255 alpha:alpha];
}
+(UIColor *)emGrayColor{
    return [self red:153 green:153 blue:153 alpha:1.0];
}
+(UIColor *)emBlackColor{
    return [self red:51 green:51 blue:51 alpha:1.0];
}
@end
