//
//  TistoryViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 20..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "TistoryViewController.h"
#import "AuthViewController.h"
@interface TistoryViewController ()

@end

@implementation TistoryViewController
@synthesize webView;

#pragma mark view method

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"티스토리", @"tistory");
        
        self.tabBarItem.image = [UIImage imageNamed:@"tistory"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad]; 
    
    [self registerGesture];
    
    NSURL* urlObj = [[NSURL alloc] initWithString:@"http://www.tistory.com"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:urlObj];
    [webView loadRequest: urlRequest];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark gesture method
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)registerGesture
{
    
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didLeftSwipe:)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [webView addGestureRecognizer:leftGesture];
    
    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didRightSwipe:)];
    rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [webView addGestureRecognizer:rightGesture];
}


-(void)didLeftSwipe:(UIGestureRecognizer *)gestureRecognizer
{
    [webView goBack];
}

-(void)didRightSwipe:(UIGestureRecognizer *)gestureRecognizer
{
    [webView goForward];
}






@end
