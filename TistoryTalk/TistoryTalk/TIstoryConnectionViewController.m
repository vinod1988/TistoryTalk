//
//  TIstoryConnectionViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 14..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "TIstoryConnectionViewController.h"

@interface TIstoryConnectionViewController ()

@end

@implementation TIstoryConnectionViewController
@synthesize connTableView; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = NSLocalizedString(@"Connect", @"Connect");
        [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:157/255.0 green:46/255.0 blue:36/255.0 alpha:1.0]];
        
         
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(onConnection:) name:@"NOTIFY_LOGIN_SWITCH_ON" object:nil];
    [nc addObserver:self selector:@selector(offConnection:) name:@"NOTIFY_LOGIN_SWITCH_OFF" object:nil];
    [nc addObserver:self selector:@selector(logIn:) name:@"NOTIFY_LOGIN" object:nil];     
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Notification

-(void)onConnection:(NSNotification *)note
{
    AuthViewController *authViewController = [[AuthViewController alloc]init];
    [self presentViewController:authViewController animated:YES completion:nil];
}

-(void)offConnection:(NSNotification *)note
{
    [StandardUserSettings setValue:TISTORY_TOKEN value:@""];
    [StandardUserSettings setValue:MY_BLOG_ADDR value:@""];
    
    [connTableView reloadData];
}


-(void)logIn:(NSNotification *)note
{
    [connTableView reloadData];
    
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
    
    
    
}

//현재 UITableView의 섹션의 개수
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int count = 1;
    
    if([StandardUserSettings exist:TISTORY_TOKEN])
    {
        count++;
    }
    
	return count;
	
}



//셀 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CELL";
    
    
    if(indexPath.section==0)
        CellIdentifier = @"SWITCH_CELL";
    else
        CellIdentifier = @"INFO_CELL";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(indexPath.section==0)
    {
        if (cell == nil)
            cell =  [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        ((SwitchCell*)cell).title.text = @"티스토리 연결";
        [((SwitchCell*)cell).switchValue setOn:[StandardUserSettings exist:TISTORY_TOKEN]] ;
    }
    else
    {
        
        if (cell == nil)
            cell =  [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
         
        ((InfoCell*)cell).title.text = @"내 블로그 정보";
        ((InfoCell*)cell).value.text = [StandardUserSettings getValue:MY_BLOG_ADDR];
        ((InfoCell*)cell).value.frame = CGRectMake(150, 6.0, 150.0, 30.0);
    }
    
    
    cell.selectionStyle = UITableViewCellEditingStyleNone;
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
	
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0)];
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = YES;
    headerLabel.textColor = [UIColor darkGrayColor];
    headerLabel.font = [UIFont systemFontOfSize:18];
    headerLabel.frame = CGRectMake(13.0, 20.0, 320.0, 20.0);
	
    
	if(section == 0)
		[headerLabel setText:@"With Tistory"];
	else
		[headerLabel setText:@"Blog Info"];
    
    
    [customView addSubview:headerLabel];
    return customView;
    
}


//헤더 섹션의 Height 크기 설정
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
    
}

@end
