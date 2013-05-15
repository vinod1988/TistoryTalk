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
@synthesize infoTableView, infoToolBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Info", @"Info");
        self.tabBarItem.image = [UIImage imageNamed:@"settings"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"red-menuBar"] forBarMetrics:UIBarMetricsDefault];
    
    isConnect = [StandardUserSettings exist:TISTORY_TOKEN];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    isConnect = [StandardUserSettings exist:TISTORY_TOKEN];
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
        TIstoryConnectionViewController *tistoryViewController = [[TIstoryConnectionViewController alloc]init];
        [self.navigationController pushViewController:tistoryViewController animated:YES];
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
        
        switch (indexPath.row)
        {
            case 0:
                
                ((InfoCell*)cell).title.text = @"Version";
                ((InfoCell*)cell).value.text = @"0.3";
                
                break;
                
            case 1:
                
                ((InfoCell*)cell).title.text = @"Created by";
                ((InfoCell*)cell).value.text = @"INDF";
                
                break;
                
                
            default:
                break;
        }
        
    }
    else
    {
        
        ((InfoCell *)cell).title.text = @"연동하기";
        if(isConnect==YES)
            ((InfoCell *)cell).value.text = @"연결";
        else
            ((InfoCell *)cell).value.text = @"비연결";
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

//섹션내아이템이몇개?
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int sectionOfRowCount = 0;
    if(section == 0)
    {
        sectionOfRowCount = 2;
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
	{
		[headerLabel setText:@"App"];
	}
	else
	{
    	[headerLabel setText:@"Tistory"];
    }
    
    [customView addSubview:headerLabel];
    return customView;
    
}


//헤더 섹션의 Height 크기 설정
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}



@end
