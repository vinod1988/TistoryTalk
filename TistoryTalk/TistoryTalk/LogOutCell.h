//
//  LogOutCell.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 21..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogOutCell : UITableViewCell
{
    
    UILabel *title;
    UISwitch *onOff;
}


@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UISwitch *onOff;

@end
