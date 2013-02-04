//
//  MapModuleView.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 23..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPRequest.h"
#import "JSONKit.h"
#import "KKCanididateDetail.h"

@interface MapModuleView : UIView
<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UISearchBar *searhBar;
    UITableView *resultView;

    NSMutableArray *kkuCanididateArray;
    KKCanididateDetail *currentSelectedCandidate; 
    
}

@property(nonatomic, retain)  UISearchBar *searhBar;
@property(nonatomic, retain)  UITableView *resultView;
@property(nonatomic, retain)   NSMutableArray *kkuCanididateArray;

@end
