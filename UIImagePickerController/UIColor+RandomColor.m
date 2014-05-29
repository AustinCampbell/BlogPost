//
//  UIColor+RandomColor.m
//  Applying MVC
//
//  Created by Austin Campbell on 5/26/14.
//  Copyright (c) 2014 Code Follows. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+(UIColor *)randomColor
{
    CGFloat red = (arc4random() % 256 / 256.0);
    CGFloat green = (arc4random() % 256 / 256.0);
    CGFloat blue = (arc4random() % 256 / 256.0);
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

/*
+(UIColor *)lightenColor
{
    
}
*/

@end
