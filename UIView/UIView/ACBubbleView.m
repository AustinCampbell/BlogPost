//
//  ACBubbleView.m
//  UIView
//
//  Created by Austin Campbell on 5/23/14.
//  Copyright (c) 2014 Austin Campbell. All rights reserved.
//

#import "ACBubbleView.h"

@interface BubbleView : UIView


@end

@implementation ACBubbleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 1, 1)];
    [[UIColor blueColor]setFill];
    
    [path fill];
    
}


@end
