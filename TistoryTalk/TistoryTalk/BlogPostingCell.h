//
//  BlogPostingCell.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 17..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogPostingCell : UITableViewCell
{
    UILabel *date;
    UILabel *week; 
    UILabel *title;
    
}

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UILabel *week; 


@end
