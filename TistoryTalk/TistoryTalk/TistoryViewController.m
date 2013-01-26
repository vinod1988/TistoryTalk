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



#pragma mark gesture method
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)didLeftSwipe:(UIGestureRecognizer *)gestureRecognizer
{
    [webView goBack];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didLeftSwipe:)];
    gesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [webView addGestureRecognizer:gesture];
    [gesture release];
    
    
    NSURL* urlObj = [[NSURL alloc] initWithString:@"http://www.idfsoft.wo.to/#"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:urlObj];
    [webView loadRequest: urlRequest];
}

-(void)viewDidAppear:(BOOL)animated
{
 
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"tistory_token"];
    NSLog(@"get token : %@", token);
     
    if(token ==nil)
    {
//    AuthViewController *authViewController = [[AuthViewController alloc] init];
//    [self presentViewController:authViewController animated:YES completion:nil];
//    //[authViewController release];
 
    }
    
    NSLog(@"ddd");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
