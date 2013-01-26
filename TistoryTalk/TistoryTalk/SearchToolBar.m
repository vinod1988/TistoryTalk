//
//  SearchToolBar.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 21..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "SearchToolBar.h"

@implementation SearchToolBar
@synthesize  searchTextField;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, 4, 300,30)];
  
        
        searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        searchTextField.borderStyle = UITextBorderStyleRoundedRect;
        searchTextField.font = [UIFont systemFontOfSize:14.0];
    
        // searchTextField.delegate = self;
        UIBarButtonItem *textFieldItem = [[[UIBarButtonItem alloc] initWithCustomView:searchTextField] autorelease];
        self.items = [NSArray arrayWithObject:textFieldItem];
        
        self.tintColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0  blue:237.0/255.0  alpha:1.0];
        
        
    }
    return self;
}



- (void)dealloc
{
	[searchTextField release];
    
	
    [super dealloc];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
