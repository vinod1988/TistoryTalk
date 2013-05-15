//
//  SwitchCell.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 14..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchCell : UITableViewCell
{
    UILabel *title;
    UISwitch *switchValue; 
}


@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UISwitch *switchValue;

@end
