//
//  TIstoryConnectionViewController.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 14..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoCell.h"
#import "SettingKeys.h"
#import "StandardUserSettings.h"
#import "SwitchCell.h"
#import "AuthViewController.h";


@interface TIstoryConnectionViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    
}

@property(nonatomic, strong) IBOutlet UITableView *connTableView;


@end
