//
//  WritterViewController.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 20..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessengerViewController.h"
#import "TagManager.h"
#import "PostingViewController.h"

@interface WritterViewController : UIViewController
<UIActionSheetDelegate>
{
    bool isWritingFile;
    IBOutlet UIWebView *webView;
    IBOutlet UILabel *noBlogData; 
    
}
@property(nonatomic, retain) IBOutlet UIWebView *webView;
@property(nonatomic, retain) IBOutlet UILabel *noBlogData;
@property bool isWritingFile;

-(IBAction)showMenu;
@end
