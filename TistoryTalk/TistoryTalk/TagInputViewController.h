//
//  TagInputViewController.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 18..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "NSPostingUpload.h"
#import "CategoryInputViewController.h"

@interface TagInputViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITextField *tagTextField;
    NSMutableArray *tagArr;
}

@property(nonatomic, strong) IBOutlet UITableView *tagTableView;
@property(nonatomic, readwrite) NSPostingUpload *postingUpload;

@end
