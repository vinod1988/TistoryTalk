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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//섹션과 row로 cell의 높이 설정
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int cellHeight = 40;
    return cellHeight;
}


#pragma mark tableView

//셀선택
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://cafe.naver.com/ideadogfoot"]];

    }
    
}

//현재 UITableView의 섹션의 개수
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
	
	
}



//셀 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       

    if (cell == nil)
    {
        if(indexPath.section==2)
        {
            cell =  [[[LogOutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        else{
            cell =  [[[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
    }
    
    

    if(indexPath.section==0)
    {
        ((InfoCell*)cell).title.text = @"1/19";
        ((InfoCell*)cell).value.text = @"테스트버전입니다.";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if(indexPath.section == 1)
    {
        
        ((InfoCell*)cell).title.text = @"HomePage";
        ((InfoCell*)cell).value.text = @"cafe.naver.com/ideadogfoot";
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    else
    {
        
        ((LogOutCell *)cell).title.text = @"로그아웃";
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
    else if(section ==1)
    {
        sectionOfRowCount = 1; 
    }
    else{
        sectionOfRowCount = 1; 
    }
    return sectionOfRowCount; 
}

//헤더 섹션 설정
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	
	if(section == 0)
	{
		
		NSArray* m_headers = [[[NSArray alloc]initWithObjects: @"공지사항", nil]autorelease];
		
		// create the parent view that will hold header Label
		UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0)] autorelease];;
		//	customView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
		// create the button object
		UILabel * headerLabel = [[[UILabel alloc] initWithFrame:CGRectZero]autorelease];
		headerLabel.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        
		headerLabel.opaque = YES;
		headerLabel.textColor = [UIColor darkGrayColor];
		//headerLabel.highlightedTextColor = [UIColor whiteColor];
		headerLabel.font = [UIFont systemFontOfSize:16];
		headerLabel.frame = CGRectMake(13.0, 20.0, 320.0, 20.0);
		//headerLabel.text = @"Put here whatever you want to display"; // i.e. array element
		// headerLabel.text = m_headers;
		[headerLabel setText:[m_headers objectAtIndex:section]];
		//NSArray인 m_headers에서 objectAtIndex:section을 이용해 section=0,1 일때 값을 빼와서 할당해 줍니다.
		
		[customView addSubview:headerLabel];
		return customView;
		
        
		
	}else if (section ==1)
	{
		
		
		NSArray* m_headers = [[[NSArray alloc]initWithObjects: @"i&DF", nil]autorelease];
		
		// create the parent view that will hold header Label
		UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0)]autorelease];
		//	customView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
		// create the button object
		UILabel * headerLabel = [[[UILabel alloc] initWithFrame:CGRectZero]autorelease];
		headerLabel.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
		
		headerLabel.opaque = YES;
		headerLabel.textColor = [UIColor darkGrayColor];
		//headerLabel.highlightedTextColor = [UIColor whiteColor];
		headerLabel.font = [UIFont systemFontOfSize:16];
		headerLabel.frame = CGRectMake(13.0, 20.0, 320.0, 20.0);
		//headerLabel.text = @"Put here whatever you want to display"; // i.e. array element
		// headerLabel.text = m_headers;
		[headerLabel setText:[m_headers objectAtIndex:0]];
		//NSArray인 m_headers에서 objectAtIndex:section을 이용해 section=0,1 일때 값을 빼와서 할당해 줍니다.
		
		[customView addSubview:headerLabel];
		return customView;
		
	}
	else if (section ==2)
	{
		NSArray* m_headers = [[[NSArray alloc]initWithObjects:@"계정설정", nil]autorelease];
		
		// create the parent view that will hold header Label
		UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0)] autorelease];
		//customView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
		// create the button object
		UILabel * headerLabel = [[[UILabel alloc] initWithFrame:CGRectZero]autorelease];
		headerLabel.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
		
		headerLabel.opaque = YES;
		headerLabel.textColor = [UIColor darkGrayColor];
		//headerLabel.highlightedTextColor = [UIColor whiteColor];
		headerLabel.font = [UIFont systemFontOfSize:16];
		headerLabel.frame = CGRectMake(13.0, 20.0, 320.0, 20.0);
		//headerLabel.text = @"Put here whatever you want to display"; // i.e. array element
		// headerLabel.text = m_headers;
		[headerLabel setText:[m_headers objectAtIndex:0]];
		//NSArray인 m_headers에서 objectAtIndex:section을 이용해 section=0,1 일때 값을 빼와서 할당해 줍니다.
		
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
