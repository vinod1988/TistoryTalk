//
//  PostingViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 27..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "PostingViewController.h"


@interface PostingViewController ()

@end

@implementation PostingViewController
@synthesize titleTextField;
 


-(id)initWithPostingTitle:(NSString*)_postingTitle
{
    if ( self = [super init] )
    {  
        titleTextField.placeholder = _postingTitle; 
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    { 
        UIBarButtonItem *nextBtn = [[UIBarButtonItem alloc] initWithTitle:@"다음" style:UIBarButtonItemStyleBordered target:self action:@selector(next:)];
        nextBtn.tintColor =[UIColor colorWithRed:0/255.0 green:102/255.0 blue:153/255.0 alpha:1.0];
        self.navigationItem.rightBarButtonItem = nextBtn;
        
        UIBarButtonItem *cancleBtn = [[UIBarButtonItem alloc] initWithTitle:@"취소" style:UIBarButtonItemStyleBordered target:self action:@selector(close:)];
        cancleBtn.tintColor =[UIColor colorWithRed:0/255.0 green:102/255.0 blue:153/255.0 alpha:1.0];
        
        self.navigationItem.leftBarButtonItem = cancleBtn;
        self.title = @"제목입력";
        
           
        
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(20, 44, 280, 60)];
        titleView.layer.borderColor = [UIColor grayColor].CGColor;
        titleView.layer.borderWidth = 0.5f;
        titleView.backgroundColor = [UIColor whiteColor];
        [[titleView layer] setCornerRadius:8];
        
        titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(10,10,260,40)]; 
        titleTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        titleTextField.borderStyle = UITextBorderStyleNone;
        titleTextField.backgroundColor= [UIColor whiteColor];
        [titleView addSubview:titleTextField];
  
        [self.view addSubview:titleView];
        
        
        [titleTextField becomeFirstResponder];
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"blue-menuBar"] forBarMetrics:UIBarMetricsDefault];
    
}
 

-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)next:(id)sender
{
    
    if(titleTextField.text.length ==0)
    {//입력이 되어 있지 않을때에는 placeholder 를 입력한다. 
        self.postingUpload.title = titleTextField.placeholder;
    }
    else
    {
        self.postingUpload.title = titleTextField.text;
    }
    
    TagInputViewController *tagInputViewController = [[TagInputViewController alloc]init];
    tagInputViewController.postingUpload = self.postingUpload; 
    [self.navigationController pushViewController:tagInputViewController animated:YES];
}
 
 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



 

@end
