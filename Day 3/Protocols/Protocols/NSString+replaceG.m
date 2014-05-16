//
//  NSString+replaceG.m
//  Protocols
//
//  Created by Austin Campbell on 5/13/14.
//  Copyright (c) 2014 Code Follows. All rights reserved.
//

#import "NSString+replaceG.h"

@implementation NSString (replaceG)

-(NSString *) replaceG;
{
    NSString *localString = self;
    
    localString = [self stringByReplacingOccurrencesOfString:@"g" withString:@""];
    localString = [localString stringByReplacingOccurrencesOfString:@"G" withString:@""];
    
    return localString;
}

@end
