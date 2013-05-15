//
//  MyBlogViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 4..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "MyBlogViewController.h"

@interface MyBlogViewController ()

@end

@implementation MyBlogViewController
@synthesize myBlogView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = NSLocalizedString(@"내 블로그", @"myblog");
        
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *myBlogAddress = [StandardUserSettings getValue:MY_BLOG_ADDR];
    
    
    if(myBlogAddress != nil)
    {
        NSURL* urlObj = [[NSURL alloc] initWithString:myBlogAddress];
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:urlObj];
        [myBlogView loadRequest: urlRequest];
    }
    else
    {//설정이 안되어 있는 경우, 경고 표시
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"티스토리 연결해주세요." message:@""
                                                      delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        [alert show];
        
        
        //TODO:아무것도 없을때도 뭔가 보여주면 좋을것 같다. 마치 404 페이지마냥 
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
