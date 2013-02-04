//
//  SearchModuleView.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 23..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchModuleView : UIView
{
    
    UISearchBar *searhBar;
    UITableView *resultView;

    
}
@property(nonatomic, retain)  UISearchBar *searhBar;

@property(nonatomic, retain)  UITableView *resultView;

@end
