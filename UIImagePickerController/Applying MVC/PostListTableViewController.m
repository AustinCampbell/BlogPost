//
//  PostListTableViewController.m
//  Applying MVC
//
//  Created by Austin Campbell on 5/12/14.
//  Copyright (c) 2014 Code Follows. All rights reserved.
//

#import "PostListTableViewController.h"
#import "Post.h"
#import "NewBlogPostViewController.h"
#import "UIColor+RandomColor.h"

@interface PostListTableViewController ()

@property NSMutableArray *blogPosts;


@end

@implementation PostListTableViewController

- (void)loadInitialData {
    Post *title1 = [[Post alloc] init];
    title1.title = @"New Post 1";
    [self.blogPosts addObject:title1];
    
    Post *title2 = [[Post alloc] init];
    title2.title = @"New Post 2";
    [self.blogPosts addObject:title2];
    
    Post *title3 = [[Post alloc] init];
    title3.title = @"New Post 3";
    [self.blogPosts addObject:title3];
    
    Post *title4 = [[Post alloc] init];
    title4.title = @"New Post 4";
    [self.blogPosts addObject:title4];
    
    Post *title5 = [[Post alloc] init];
    title5.title = @"New Post 5";
     [self.blogPosts addObject:title5];
    
    Post *title6 = [[Post alloc] init];
    title6.title = @"New Post 6";
    [self.blogPosts addObject:title6];

    Post *title7 = [[Post alloc] init];
    title7.title = @"New Post 7";
    [self.blogPosts addObject:title7];

    Post *title8 = [[Post alloc] init];
    title8.title = @"New Post 8";
    [self.blogPosts addObject:title5];

    Post *title9 = [[Post alloc] init];
    title9.title = @"New Post 9";
    [self.blogPosts addObject:title9];
    
    Post *title10 = [[Post alloc] init];
    title10.title = @"New Post 10";
    [self.blogPosts addObject:title10];


}

-(IBAction)unwindToList: (UIStoryboardSegue *)segue;
{
    NewBlogPostViewController *source = [segue sourceViewController];
    Post *title =source.post;
    if (title != nil) {
        [self.blogPosts addObject:title];
        [self.tableView reloadData];
    }
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.blogPosts = [[NSMutableArray alloc] init];
    [self loadInitialData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.blogPosts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Post *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
    cell.textLabel.text =blogPost.title;
    cell.backgroundColor = [UIColor randomColor];
    
    
    return cell;
}


@end
