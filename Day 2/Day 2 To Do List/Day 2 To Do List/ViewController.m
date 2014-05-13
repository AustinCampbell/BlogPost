//
//  ViewController.m
//  Applying MVC
//
//  Created by Austin Campbell on 5/8/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ViewController.h"
#import "BlogPost.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *posts;
@property (nonatomic, weak) UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.posts = [NSMutableArray new];
    for (int i=0; i<20; i++){
        Post *posts = [[Post alloc] init];
        posts.title = [NSString stringWithFormat:@"Post #%d", i];
}
    [self.posts addObject: Post];
    
}

[self.tableView reloadData];

#pragma mark - UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    - (void)setPost:(Post *)post
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *posts = [self.posts objectAtIndex:indexPath.row];
    cell.textLabel.text = posts.title;
}




@end



















