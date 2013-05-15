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
#import "PopoverView.h"

@interface WritterViewController : UIViewController
<PopoverViewDelegate>
{
    bool isWritingFile;
    NSArray *menuStrArr;
    
    IBOutlet UIWebView *webView;
    IBOutlet UILabel *noBlogData; 
    
}
@property(nonatomic, strong) IBOutlet UIWebView *webView;
@property(nonatomic, strong) IBOutlet UILabel *noBlogData;
@property bool isWritingFile;

-(IBAction)showMenu:(id)sender;

@end
