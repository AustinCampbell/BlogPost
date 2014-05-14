//
//  TaskTableViewCell.m
//  TaskApp
//
//  Created by Austin Campbell on 5/13/14.
//  Copyright (c) 2014 Code Follows. All rights reserved.
//

#import "TaskTableViewCell.h"
#import "Task.h"

@implementation TaskTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
