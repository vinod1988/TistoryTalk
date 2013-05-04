//
//  AuthViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 25..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "AuthViewController.h"

@interface AuthViewController ()

@end

@implementation AuthViewController
@synthesize authWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL* urlObj = [[NSURL alloc] initWithString:@"https://www.tistory.com/oauth/authorize?client_id=76f30e50a21087cd8581813762365396&redirect_uri=http://indf.net&response_type=token"];
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:urlObj];
    [authWebView loadRequest: urlRequest];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *currentURL = webView.request.mainDocumentURL.absoluteString;
    
    NSString *flag =  [currentURL substringFromIndex:currentURL.length-5];
    
    if([flag isEqualToString:@"token"])
    {
        //login view
    }
    else
    {
        NSRange aRange = [currentURL rangeOfString:@"access_token"];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        if (aRange.location ==NSNotFound)
        {
            [nc postNotificationName:@"NOTIFY_LOGOUT" object:nil userInfo:nil];
        }
        else
        {
            NSArray * splittedAr = [currentURL componentsSeparatedByString:@"="];
            [TistoryAuth setToken:[splittedAr objectAtIndex:1]];
            [nc postNotificationName:@"NOTIFY_LOGIN" object:nil userInfo:nil];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

-(IBAction)cancel:(id)sender
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"NOTIFY_LOGOUT" object:nil userInfo:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
