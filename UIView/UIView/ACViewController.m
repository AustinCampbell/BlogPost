//
//  ACViewController.m
//  UIView
//
//  Created by Austin Campbell on 5/22/14.
//  Copyright (c) 2014 Austin Campbell. All rights reserved.
//

#import "ACViewController.h"


@interface ACViewController ()


@property (strong, nonatomic) UIView *bubbleView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior * collision;

@end

@implementation ACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    
 	CGRect bubbleView = CGRectMake(120, 0, 60, 60);
   
    _bubbleView = [[UIView alloc]initWithFrame:bubbleView];
    _bubbleView.backgroundColor = [UIColor cyanColor];
    _bubbleView.layer.borderColor = [UIColor blueColor].CGColor;
    _bubbleView.layer.borderWidth = 1.f;
     _bubbleView.layer.cornerRadius = _bubbleView.frame.size.width / 2.0;
    [self.view addSubview:_bubbleView];
   
    
    [_bubbleView.layer addAnimation:[self pulseOpacityAnimation] forKey:@"pulse opacity"];
    
    [self setUpGravity];
    
    
    }


- (void)setUpGravity
{
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc]initWithItems:@[_bubbleView]];
    [_animator addBehavior:_gravity];
    _collision = [[UICollisionBehavior alloc]initWithItems:@[_bubbleView]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    for (UITouch *touch in touches) {
        
        if ([touch.view isEqual:_bubbleView]) {
            CGPoint touchPoint = [touch locationInView:_bubbleView.superview];
            _bubbleView.center = touchPoint;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        
        if ([touch.view isEqual:_bubbleView]) {
            
            [UIView animateWithDuration:0.2 animations:^{
                _bubbleView.transform = CGAffineTransformScale(_bubbleView.transform, 0.8, 0.8);
            }];
        }
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        
        if ([touch.view isEqual:_bubbleView]) {
            [_bubbleView.layer removeAnimationForKey:@"pulse opacity"];
            [UIView animateWithDuration:0.2 animations:^{
                _bubbleView.transform = CGAffineTransformScale(_bubbleView.transform, 1.25, 1.25);
            }];
        }
        
       }
    }


- (CAAnimation *)pulseOpacityAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(1.0);
    animation.toValue = @(0.5);
    animation.repeatCount = HUGE_VALF;
    animation.duration = 0.4;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animation;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
