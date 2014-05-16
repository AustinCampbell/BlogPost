//
//  ViewController.m
//  Protocols
//
//  Created by Austin Campbell on 5/13/14.
//  Copyright (c) 2014 Code Follows. All rights reserved.
//

#import "ViewController.h"
#import "NSString+replaceG.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *testSTring = @"Good Moring good Sir!";
    
    NSLog(@"%@", [testSTring replaceG]);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
