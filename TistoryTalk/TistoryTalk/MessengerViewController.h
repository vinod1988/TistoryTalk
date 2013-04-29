//
//  MessengerViewController.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 21..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchToolBar.h"
#import "UIBubbleTableView.h"
#import "SearchModuleView.h"
#import "MapModuleView.h"
#import "DataManager.h"

typedef enum _NSCurrentMainView
{
    MainView = 0,
    SearchModule = 1,
    MapModule = 2
} NSCurrentMainView;


@interface MessengerViewController : UIViewController
<UIBubbleTableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>
{
    SearchToolBar* searchToolbar;
    IBOutlet UIBubbleTableView *bubbleTableView;
    NSMutableArray *bubbleData;
    int prevNSBubbleTypingType;
    
    IBOutlet UIView *mainView;
    IBOutlet UIBarButtonItem *rightButton;
    IBOutlet UIBarButtonItem *leftButton;
    IBOutlet UILabel *titleLabel; 
    
    SearchModuleView *searchModuleView ;
    MapModuleView *mapModuleView;
}

@property(nonatomic, strong) SearchToolBar* searchToolbar;
@property(nonatomic, strong) IBOutlet UIView *mainView;
@property NSCurrentMainView currentMainView;

@property(nonatomic, strong) IBOutlet UIBarButtonItem *rightButton;
@property(nonatomic, strong) IBOutlet UIBarButtonItem *leftButton;
@property(nonatomic, strong) IBOutlet UILabel *titleLabel;

-(IBAction)leftBtnClicked;
-(IBAction)rightBtnClicked;
@end
