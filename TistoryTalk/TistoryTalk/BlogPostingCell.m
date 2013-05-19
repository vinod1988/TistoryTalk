//
//  BlogPostingCell.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 17..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "BlogPostingCell.h"

@implementation BlogPostingCell
@synthesize date, title, week;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        date = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 12.0, 50.0, 20.0)];
        week = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 30, 50, 20)];
		title = [[UILabel alloc] initWithFrame:CGRectMake(80, 13.0, 200.0, 30.0)];
        
        date.font = [UIFont systemFontOfSize:18];
        week.font = [UIFont systemFontOfSize:11];
		title.font = [UIFont systemFontOfSize:15];
		 
        date.textAlignment = NSTextAlignmentCenter;
        week.textAlignment = NSTextAlignmentCenter;
        
        
        date.textColor = [UIColor darkGrayColor];
        week.textColor = [UIColor grayColor];
        
		[self addSubview:title];
        [self addSubview:week];
		[self addSubview:date];
        
        
        [self.backgroundView setHidden:YES];
        self.backgroundColor = [UIColor whiteColor];
        self.opaque = NO;
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
