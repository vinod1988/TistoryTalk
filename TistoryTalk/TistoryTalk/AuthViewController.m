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
    // Do any additional setup after loading the view from its nib.
    
    
    NSURL* urlObj = [[NSURL alloc] initWithString:@"http://211.43.193.18/auth.jsp"];
    
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
    NSLog(@"%@", currentURL);
    
    NSRange aRange = [currentURL rangeOfString:@"access_token"];
    if (aRange.location ==NSNotFound)
    {
        //not exist
    }
    else
    {
        //NSLog(@"string was at index %d ",aRange.location);
        
        NSArray * splittedAr = [currentURL componentsSeparatedByString:@"="];
        
        NSLog(@"atoken : %@", [splittedAr objectAtIndex:1]);
        //[[NSUserDefaults standardUserDefaults] setObject:<object> forKey:<key value>];
        [[NSUserDefaults standardUserDefaults] setObject:[splittedAr objectAtIndex:1] forKey:@"tistory_token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
    
}
@end
