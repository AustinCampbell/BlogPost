//
//  ViewController.m
//  TaskApp
//
//  Created by Austin Campbell on 5/13/14.
//  Copyright (c) 2014 Code Follows. All rights reserved.
//

#import "ViewController.h"
#import "Task.h"

@interface ViewController ()

static NSString * const TaskCellIdentifier =@"TaskCell";
@property (strong, nonatomic)NSArray *posts;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	for (int i = 0; i < 10; i++) {
        Task *post = [[task alloc]init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
