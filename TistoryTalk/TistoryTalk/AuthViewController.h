//
//  AuthViewController.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 25..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthViewController : UIViewController
<UIWebViewDelegate>
{
    IBOutlet UIWebView *authWebView;
}

@property(nonatomic, retain) IBOutlet UIWebView *authWebView; 
@end
