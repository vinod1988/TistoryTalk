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
        [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:157/255.0 green:46/255.0 blue:36/255.0 alpha:1.0]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.authNavBar setBackgroundImage:[UIImage imageNamed:@"red-menuBar"] forBarMetrics:UIBarMetricsDefault];
    
    
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
    
    if(![flag isEqualToString:@"token"])
    {
        NSRange aRange = [currentURL rangeOfString:@"access_token"];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        if (aRange.location == NSNotFound)
        {
            [nc postNotificationName:@"NOTIFY_LOGOUT" object:nil userInfo:nil];
        }
        else
        {
            
            //save access_token
            NSArray * splittedAr = [currentURL componentsSeparatedByString:@"="];
            NSString *accessToken = [splittedAr objectAtIndex:1];
            [StandardUserSettings setValue:TISTORY_TOKEN value:accessToken];
            
            //save myblogurl
            MyBlogApi *myBlogApi = [[MyBlogApi alloc]init];
            NSString *basicBlogUrl = [myBlogApi getMyBasicBlogUrl];
            [StandardUserSettings setValue:MY_BLOG_ADDR value:basicBlogUrl];
              
            
            [nc postNotificationName:@"NOTIFY_LOGIN" object:nil userInfo:nil];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
