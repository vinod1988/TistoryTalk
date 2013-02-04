//
//  SearchModuleView.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 23..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "SearchModuleView.h"

@implementation SearchModuleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor yellowColor];
        
        searhBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        [self addSubview:searhBar];
        
        resultView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 480-44)];
        //resultView.delegate = self;
        //resultView.dataSource = self;
         
        
        UISwipeGestureRecognizer *leftSwipegesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didLeftSwipe:)];
        leftSwipegesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [resultView addGestureRecognizer:leftSwipegesture];
        [leftSwipegesture release];
        
                       [self addSubview:resultView];
        
        
    }
    return self;
}

-(void)didLeftSwipe:(UIGestureRecognizer *)gestureRecognizer
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.frame = CGRectMake(-320, 44, 320, 480-44);
    
    [UIView commitAnimations];
    
    [self endEditing:YES];
    
    
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
