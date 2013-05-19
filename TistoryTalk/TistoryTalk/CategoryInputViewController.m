//
//  CategoryInputViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 18..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "CategoryInputViewController.h"

@interface CategoryInputViewController ()

@end

@implementation CategoryInputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    { 
        UIBarButtonItem *completeBtn = [[UIBarButtonItem alloc] initWithTitle:@"완료" style:UIBarButtonItemStyleBordered target:self action:@selector(complete:)];
        completeBtn.tintColor =[UIColor colorWithRed:0/255.0 green:102/255.0 blue:153/255.0 alpha:1.0];
        self.navigationItem.rightBarButtonItem = completeBtn;
        
        UIBarButtonItem *cancleBtn = [[UIBarButtonItem alloc] initWithTitle:@"취소" style:UIBarButtonItemStyleBordered target:self action:@selector(close:)];
        cancleBtn.tintColor =[UIColor colorWithRed:0/255.0 green:102/255.0 blue:153/255.0 alpha:1.0];
        
        self.navigationItem.leftBarButtonItem = cancleBtn;
        self.title = @"카테고리 선택";
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //카텔고리 API 에서 카테로리를 가져온다.
    CategoryApi *categoryApi = [[CategoryApi alloc]init];
    categorytInfoArr = [categoryApi getAllCategory];
    
    [self registerNotification];
}

-(void)registerNotification
{
    
    //포스트 등록여부에 대한 Notification
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(didPostSuccess:) name:@"NOTIFY_POST_SUCCESS" object:nil];
    [nc addObserver:self selector:@selector(didPostFail:) name:@"NOTIFY_POST_FAIL" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)complete:(id)sender
{
    [self post];
    
    //뷰를 내리는 부분은 Notification 에서 담당한다. 
}

-(void)post
{
    
    CategoryInfo *catInfo = [categorytInfoArr objectAtIndex:selectedRow];
    
    self.postingUpload.categoryID = catInfo.categoryId;
    
    WriteApi *writeApi = [[WriteApi alloc]init];
    [writeApi post:self.postingUpload.title
              tags:self.postingUpload.tags categoryID:self.postingUpload.categoryID content:self.postingUpload.postingHtmlContent];
 
    
}


#pragma mark Notification Handler


-(void) didPostSuccess:(NSNotification *)noti
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"포스팅 성공" message:@""
                                                  delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    [alert show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void) didPostFail:(NSNotification *)noti
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"포스팅 실패" message:@""
                                                  delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    [alert show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark tableview codes
 

//섹션과 row로 cell의 높이 설정
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int cellHeight = 40;
    return cellHeight;
}



//셀선택
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = indexPath.row;
    
    [tableView reloadData];
}

//셀 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CELL";
    
    CRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[CRTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CategoryInfo *catInfo = [categorytInfoArr objectAtIndex:indexPath.row];
    cell.textLabel.text = catInfo.label;  
    
    
    if(selectedRow == indexPath.row)
        cell.isSelected = YES;
    else
        cell.isSelected = NO;
    
    
    return cell;
}

//섹션내아이템이몇개?
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return categorytInfoArr.count; 
}




@end
