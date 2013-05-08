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

@interface MapModuleView : UIView
<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UISearchBar *searhBar;
    UITableView *resultView;
 
    
}

@property(nonatomic, strong)  UISearchBar *searhBar;
@property(nonatomic, strong)  UITableView *resultView; 

@end
