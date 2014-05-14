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
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
