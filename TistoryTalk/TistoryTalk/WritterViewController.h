//
//  WritterViewController.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 20..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessengerViewController.h"
#import "TagManager.h"
#import "PostingViewController.h"
#import "PopoverView.h"
#import "BlogPostingCell.h"
#import "NSDateUtils.h"
#import "TistoryHtmlTagManager.h"

@interface WritterViewController : UIViewController
<PopoverViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSArray *menuStrArr;
    NSMutableArray *postingIndexArr;
    NSMutableArray  *selectedIndexPathArr;
    
}

@property(nonatomic, strong) IBOutlet UITableView *savedBlogDataTableView;

-(IBAction)showMenu:(id)sender;

@end
