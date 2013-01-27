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
    
    IBOutlet  UIView *mainView;
    IBOutlet UIBarButtonItem *editButton;
    IBOutlet UIBarButtonItem *closeButton;
    
    SearchModuleView *searchModuleView ;
    MapModuleView *mapModuleView;
}

@property(nonatomic, retain) SearchToolBar* searchToolbar;
@property(nonatomic, retain) IBOutlet UIView *mainView;
@property NSCurrentMainView currentMainView;

@property(nonatomic, retain)
IBOutlet UIBarButtonItem *editButton;
@property(nonatomic, retain)
IBOutlet UIBarButtonItem *closeButton;

-(IBAction)closeViewController;
-(IBAction)clickEditBtn; 
@end
