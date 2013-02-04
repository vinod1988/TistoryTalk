//
//  PostingViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 27..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "PostingViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface PostingViewController ()

@end

@implementation PostingViewController
@synthesize  categoryButton, titleTextField, content, pickerView, selectedCategoryId, actionSheet; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //init
        
        myBlogParser = [[MyBlogInfoParser alloc]init];
        categoryParser = [[CategoryParser alloc]init];
        
        
        // Custom initialization
        UIView *titleView = [[[UIView alloc]initWithFrame:CGRectMake(20, 44+20, 280, 60)]autorelease];
        
        //view border
        titleView.layer.borderColor = [UIColor grayColor].CGColor;
        titleView.layer.borderWidth = 0.5f;
        titleView.backgroundColor = [UIColor whiteColor];
        [[titleView layer] setCornerRadius:8];
        
        titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(10,10,260,40)];
        //titleTextField.backgroundColor = [UIColor redColor];
        titleTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        titleTextField.placeholder = @"제목";
        titleTextField.borderStyle = UITextBorderStyleNone;
        titleTextField.backgroundColor= [UIColor whiteColor];
        [titleView addSubview:titleTextField];
        [self.view addSubview:titleView];
        
        
        [titleTextField becomeFirstResponder];
        
    }
    return self;
}
-(IBAction)category:(id)sender
{
    categoryIdName = [categoryParser requestCategory];
    
    
    // 액션쉬트를 하나 만들어 줍니다.. 버튼을 선택하면 아래쪽에서 짜잔 하고 나타나게 말이죠..
     actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    // PickerView의 화면 크기를 설정하고요...
    CGRect pickerFrame = CGRectMake(0, 40, 320, 150);
    
    // PickerView도 할당해 줍니다..
    pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    
    // 닫기 버튼을 만들어 줍니다..
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(closePictkerView:) forControlEvents:UIControlEventValueChanged];
    
    // 닫기 버튼도 액션쉬트에 붙여 줍니다..
    [actionSheet addSubview:closeButton];

    
    
    
    // 그리고 액션쉬트에다가 피커뷰를 붙여 줍니다..
    [actionSheet addSubview:pickerView];
    
  
    // 액션쉬트를 뷰에 보여주고
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 385)];

    
    
}

-(IBAction)closePictkerView:(id)sender
{
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    
    
    NSArray *idName = [[categoryIdName objectForKey:[NSString stringWithFormat:@"%d", selectedRow]] componentsSeparatedByString:@"??"];
     
    categoryButton.titleLabel.text =[NSString stringWithFormat:@"  %@",  [idName objectAtIndex:1]];

    
    selectedCategoryId = [idName objectAtIndex:0];
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}


-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(IBAction)posting:(id)sender
{
    //add pickerview;
    
    // 접속할 주소 설정
	NSString *url = @"https://www.tistory.com/apis/post/write";
	
	// HTTP Request 인스턴스 생성
	HTTPRequest *httpRequest = [[HTTPRequest alloc] init];
	
	// POST로 전송할 데이터 설정
	NSMutableDictionary *bodyObject = [[NSMutableDictionary alloc]init];
    
    
    NSString* accessToken  = [[NSUserDefaults standardUserDefaults] stringForKey:@"tistory_token"];
    NSString* targetUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"my_blog"];
    
    
    if(targetUrl.length == 0)
    {
        [myBlogParser requestMyBlogInfo:accessToken];
        
        targetUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"my_blog"];
        
    }
    
    
    [bodyObject setValue:accessToken forKey:@"access_token"];
    [bodyObject setValue:targetUrl forKey:@"targetUrl"];
    [bodyObject setValue:@"0" forKey:@"category"];
    [bodyObject setValue:titleTextField.text forKey:@"title"];
    [bodyObject setValue:content forKey:@"content"]; 
    
    
    
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:url bodyObject:bodyObject];
    
    [bodyObject release];
    
}

- (void)didReceiveFinished:(NSString *)result
{
    
    NSRange okRange = [result rangeOfString:@"<status>200</status>"];
    
    if (okRange.location != NSNotFound)
    {
        //success 
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"포스팅 성공" message:@""
                                                      delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        [alert show];
        [alert release]; 
        
    }
    else
    {
        
        
        NSRange atokenRange = [result rangeOfString:@"만료"];
        if(atokenRange.location != NSNotFound)
        {//ACCESS_TOKEN EXPIRED
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"인증을 다시 합니다." message:@""
                                                          delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
             
            
            AuthViewController *authViewController = [[AuthViewController alloc] init];
            [self presentViewController:authViewController animated:YES completion:nil];
            [authViewController release];
        }
        else
        {    
            //fail 
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"포스팅 실패" message:@""
                                                          delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
}

// 특정 버튼을 눌러서 종료된 후에 실행된다.
 
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    
    if([alertView.title isEqualToString:@"포스팅 성공"])
    {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"REMOVE_DATA" object:self userInfo:nil];
        
    }
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
  
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




// 필수 사용메소드 2개 : 이 작업을 하면 피커에 데이터가 들어간다.
// 피커를 사용하기 위해 반드시 사용되어야 할 필수 메소드이다.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

// 피커를 사용하기 위해 반드시 사용되어야 할 필수 메소드이다.
- (NSInteger)pickerView:(UIPickerView *) pickerView numberOfRowsInComponent : (NSInteger)component{
	
    return categoryIdName.count; 
}

// 피커를 사용하기 위해 반드시 사용되어야 할 필수 델리게이트이다.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component{

    NSString *cIdName = [categoryIdName objectForKey:[NSString stringWithFormat:@"%d", row]];
    
    NSArray *idName = [cIdName componentsSeparatedByString:@"??"];
    
    
    return [idName objectAtIndex:1];
}
 

@end
