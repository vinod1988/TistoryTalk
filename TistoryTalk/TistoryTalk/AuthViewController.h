//
//  AuthViewController.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 25..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "StandardUserSettings.h"
#import "SettingKeys.h"
#import "MyBlogApi.h"

@interface AuthViewController : UIViewController
<UIWebViewDelegate>
{
    IBOutlet UIWebView *authWebView;
}

@property(nonatomic, strong) IBOutlet UIWebView *authWebView;
@property(nonatomic, strong) IBOutlet UINavigationBar *authNavBar; 
-(IBAction)cancel:(id)sender;

@end
