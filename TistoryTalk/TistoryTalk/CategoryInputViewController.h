//
//  CategoryInputViewController.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 18..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryApi.h"
#import "CategoryInfo.h"
#import "CRTableViewCell.h"
#import "NSPostingUpload.h"
#import "WriteApi.h"

@interface CategoryInputViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *categorytInfoArr;
     int selectedRow; 
}

@property(nonatomic, readwrite) NSPostingUpload *postingUpload;
@end
