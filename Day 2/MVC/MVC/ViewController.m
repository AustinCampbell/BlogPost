//
//  ViewController.m
//  MVC
//
//  Created by Austin Campbell on 5/8/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"

@interface ViewController () <UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    
    Photo *photo = [[Photo alloc] init];
  // this is shorthand for above  Photo *Photo = [Photo new];
    photo.caption = @"My First Photo";
    photo.date = [NSDate date];
    photo.location = @"Seattle";
    
    NSLog (@"Photo: %@", photo.caption);
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
