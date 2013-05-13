//
//  InfoViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 20..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize infoTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"info", @"info");
        self.tabBarItem.image = [UIImage imageNamed:@"settings"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(logIn:) name:@"NOTIFY_LOGIN" object:nil];
    [nc addObserver:self selector:@selector(logInComplete:) name:@"NOTIFY_LOGIN_COMPLETE" object:nil];
    [nc addObserver:self selector:@selector(logOut:) name:@"NOTIFY_LOGOUT" object:nil];
    

    isConnect = [StandardUserSettings exist:TISTORY_TOKEN];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark notifcation codes
-(void)logInComplete:(NSNotification *)note
{
    
}

-(void)logIn:(NSNotification *)note
{
    NSLog(@"LOGIN");
    
    isConnect = YES;
    [infoTableView reloadData];
    
}

-(void)logOut:(NSNotification *)note
{
    NSLog(@"LOGOUT");
    
    isConnect = NO;
    
    //init settings 
    [StandardUserSettings setValue:TISTORY_TOKEN value:@""];
    [infoTableView reloadData];
}



#pragma mark tableView

//섹션과 row로 cell의 높이 설정
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int cellHeight = 40;
    return cellHeight;
}



//셀선택
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://blog.indf.net"]];
    }
    else
    {
        
        AuthViewController *authViewController = [[AuthViewController alloc]init];
        [self presentViewController:authViewController animated:YES completion:nil];
    }
    
}

//현재 UITableView의 섹션의 개수
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
	
}



//셀 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil)
    {
        
        cell =  [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    
    
    if(indexPath.section==0)
    {
        ((InfoCell*)cell).title.text = @"INDF";
        ((InfoCell*)cell).value.text = @"생각에 가치를 더하는 IDNF";
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    else
    {
        
        ((InfoCell *)cell).title.text = @"티스토리 연결";
        if(isConnect==YES)
            ((InfoCell *)cell).value.text = @"연결";
        else
            ((InfoCell *)cell).value.text = @"비연결";
        
            
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    
    return cell;
}

//섹션내아이템이몇개?
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int sectionOfRowCount = 0;
    if(section == 0)
    {
        sectionOfRowCount = 1;
    }
    else
    {
        sectionOfRowCount = 1;
    }
    return sectionOfRowCount;
}

//헤더 섹션 설정
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	
	if(section == 0)
	{
        
		UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0)];
		UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		headerLabel.backgroundColor = [UIColor clearColor];
		headerLabel.opaque = YES;
		headerLabel.textColor = [UIColor darkGrayColor];
		headerLabel.font = [UIFont systemFontOfSize:16];
		headerLabel.frame = CGRectMake(13.0, 20.0, 320.0, 20.0);
		[headerLabel setText:@"팀 소개"];
		[customView addSubview:headerLabel];
		return customView;
		
	}
	else
	{
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0)];
		UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		headerLabel.backgroundColor = [UIColor clearColor];
		headerLabel.opaque = YES;
		headerLabel.textColor = [UIColor darkGrayColor];
		headerLabel.font = [UIFont systemFontOfSize:16];
		headerLabel.frame = CGRectMake(13.0, 20.0, 320.0, 20.0);
		[headerLabel setText:@"계정설정"];
		[customView addSubview:headerLabel];
		return customView;
    }
    
}


//헤더 섹션의 Height 크기 설정
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;	
}



@end
