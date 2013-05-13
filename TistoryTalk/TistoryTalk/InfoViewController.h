//
//  InfoViewController.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 20..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoCell.h" 
#import "AuthViewController.h"
#import "SettingKeys.h"
#import "StandardUserSettings.h"

@interface InfoViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    bool isConnect; 
}

@property (nonatomic, strong) IBOutlet UITableView  *infoTableView;


@end
