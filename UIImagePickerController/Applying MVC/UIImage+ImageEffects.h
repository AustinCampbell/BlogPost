//
//  UIImage+ImageEffects.h
//  Applying MVC
//
//  Created by Austin Campbell on 5/26/14.
//  Copyright (c) 2014 Code Follows. All rights reserved.
//

#import <UIKit/UIKit.h>

@import UIKit;

@interface UIImage (ImageEffects)

-(UIImage *)applyLightEffect;
-(UIImage *)applyExtraLightEffect;
-(UIImage *)applyDarkEffect;
-(UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

-(UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
