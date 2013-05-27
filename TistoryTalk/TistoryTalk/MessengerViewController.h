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
#import "DataManager.h" 
#import "NSPosting.h"
#import "NSPostingIndex.h"
#import "NSMD5Utils.h"
#import "NSFontAccessory.h"


@interface MessengerViewController : UIViewController
<UIBubbleTableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate, CMTextStylePickerViewControllerDelegate>

{
    SearchToolBar* searchToolbar; 
    NSPosting *posting; 
    int prevNSBubbleTypingType;
    NSString *loadFileName;
    NSIndexPath *selectedIndexPath;
    
     
}

@property(nonatomic, strong) SearchToolBar* searchToolbar; 


@property(nonatomic, strong) IBOutlet UIBubbleTableView *bubbleTableView; 
@property(nonatomic, strong) IBOutlet UIBarButtonItem *editButton;
@property(nonatomic, strong) IBOutlet UIBarButtonItem *closeButton;
@property(nonatomic, strong) IBOutlet UILabel *titleLabel; 



-(IBAction)closeBtnClicked;
-(IBAction)editBtnClicked;

-(id)initWithFile:(NSString*)fileName;

@end
