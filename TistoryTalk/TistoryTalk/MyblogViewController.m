//
//  MyblogViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 20..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "MyblogViewController.h"

@interface MyblogViewController ()

@end

@implementation MyblogViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
          self.title = NSLocalizedString(@"블로그", @"myblog");
        
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


    NSURL* urlObj = [[NSURL alloc] initWithString:@"http://211.43.193.18/myblog.html"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:urlObj];
    [webView loadRequest: urlRequest];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
