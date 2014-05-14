//
//  TaskTableViewCell.h
//  TaskApp
//
//  Created by Austin Campbell on 5/13/14.
//  Copyright (c) 2014 Code Follows. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;

@interface TaskTableViewCell : UITableViewCell

//post property
@property (weak, nonatomic) Task *task;

@end
