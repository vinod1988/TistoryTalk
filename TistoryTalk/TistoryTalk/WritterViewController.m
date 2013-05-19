//
//  WritterViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 20..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//


#import "WritterViewController.h"
#define kExistMenuStrArr [NSArray arrayWithObjects:@"포스팅하기", @"이어쓰기", @"지우기",nil]
#define kNewMenuStrArr [NSArray arrayWithObjects:@"새글쓰기",nil]
#define kMultiExistMenuStrArr [NSArray arrayWithObjects:@"지우기", nil]

@interface WritterViewController ()

@end

@implementation WritterViewController
@synthesize  savedBlogDataTableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"글쓰기", @"writer");
        self.tabBarItem.image = [UIImage imageNamed:@"bubble"];
        
        UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc] initWithTitle:@"메뉴" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu:)];
        menuBtn.tintColor =[UIColor colorWithRed:0/255.0 green:102/255.0 blue:153/255.0 alpha:1.0];
        self.navigationItem.rightBarButtonItem = menuBtn;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"blue-menuBar"] forBarMetrics:UIBarMetricsDefault];
    
    [self registerNotification];
    
    
    DataManager *dm = [DataManager singleTon_GetInstance];
    postingIndexArr = [dm loadPostingIndexFromFile:@"posting_file_index"];
    
    if(postingIndexArr == nil)
        postingIndexArr = [[NSMutableArray alloc]init];
    
    selectedIndexPathArr = [[NSMutableArray alloc]init];
     
    
}

-(void)registerNotification
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
       [nc addObserver:self selector:@selector(savePostingIndex:) name:@"NOTIFY_SAVE_POSTING" object:nil];
     
}


- (void) viewWillAppear:(BOOL)animated
{
    //[self preview];
    
    [savedBlogDataTableView reloadData];
}
 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Notification Handler
 

-(void) savePostingIndex:(NSNotification *)noti
{//NSPosting 파일이 MessengerView 에서 저장이 되면,
 //NSPostingIndex가 Notification에 달려서 전달되어 온다.
    
    NSPostingIndex* receivedPostingIndex = (NSPostingIndex*)noti.object;
    
    [postingIndexArr addObject:receivedPostingIndex];
    
    
    //파일에 바로 저장
    DataManager *dm = [DataManager singleTon_GetInstance];
    [dm savePostingIndexToFile:postingIndexArr filename:@"posting_file_index"];
    
    //테이블뷰 리로드
    [savedBlogDataTableView reloadData];
    
}



#pragma mark PopOverView

-(void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index
{
    //NSLog(@"%s item:%d", __PRETTY_FUNCTION__, index);
    NSString *menuStr = [menuStrArr objectAtIndex:index];
    // Dismiss the PopoverView after 0.5 seconds
    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.3f];
    
    [self doMenu:menuStr];
}

-(void)popoverViewDidDismiss:(PopoverView *)popoverView
{
   /// NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void)doMenu:(NSString*)_menuStr
{
    if([_menuStr isEqual:@"새글쓰기"])
    {
        [self doNewWriting:_menuStr];
    }
    else if([_menuStr isEqual:@"포스팅하기"])
    {
        [self doPosting];
    }
    else if([_menuStr isEqual:@"이어쓰기"])
    {
        [self doReWriting:_menuStr];
    }
    else if([_menuStr isEqual:@"지우기"])
    {
        [self doDelete];
    }
}

-(void)doNewWriting:(NSString*)title
{
    MessengerViewController *messengerViewController = [[MessengerViewController alloc]initWithFile:nil];
    messengerViewController.titleLabel.text = title;
    [self presentViewController:messengerViewController animated:YES completion:nil];
}


-(void)doPosting
{
    //선택한 포스팅의 파일이름을 가져온다.
    NSIndexPath*selectedOneIndexPath = [selectedIndexPathArr objectAtIndex:0];
    NSPostingIndex* selectedPostingIndex =  [postingIndexArr objectAtIndex:selectedOneIndexPath.row];
    
    
    DataManager *dm = [DataManager singleTon_GetInstance];
    
    
    TistoryHtmlTagManager *htmlTagManager = [TistoryHtmlTagManager singleTon_GetInstance];
    NSPosting *loadPosting = [dm loadPostingFromFile:selectedPostingIndex.getFileName]; 
    NSString* totalHtml = [htmlTagManager convertHtmlDocument:[loadPosting getPostingData]];
    

    
    //PostingViewController 
    PostingViewController *postingViewController = [[PostingViewController alloc]initWithPostingTitle:[loadPosting getTempTitle]];
    
    NSPostingUpload *postingUpload = [[NSPostingUpload alloc]init];
    postingUpload.postingHtmlContent = totalHtml; 
    postingViewController.postingUpload = postingUpload;
    
    //UINavigationController 장착
    UINavigationController *postingNavigationController = [[UINavigationController alloc] initWithRootViewController:postingViewController];

    [self presentViewController:postingNavigationController animated:YES completion:nil];

    //모든 선택 해제 
    [selectedIndexPathArr removeAllObjects];
}


-(void)doReWriting:(NSString*)title
{
    //선택한 포스팅의 파일이름을 가져온다. 
    NSIndexPath*selectedOneIndexPath = [selectedIndexPathArr objectAtIndex:0];
    NSPostingIndex* selectedPostingIndex =  [postingIndexArr objectAtIndex:selectedOneIndexPath.row];
    
    
    MessengerViewController *messengerViewController = [[MessengerViewController alloc] initWithFile:[selectedPostingIndex getFileName]];
    messengerViewController.titleLabel.text = title;
    
    
    
    [selectedIndexPathArr removeAllObjects];
    
    [self presentViewController:messengerViewController animated:YES completion:nil];
    
}

-(void)doDelete
{//지우기,
    /* for selectedIndexArr;
    1) posingIndexArr 에서선택된것을가져온다.
    2) 가져온 postingIndex 의filename 을 가지고 해당파일을 지운다.
    3) postingIndexArr 에서해당 postingIndex 를제거한다.
    4) postingIndexArr 를 파일에쓴다.
    4) selectedIndexPathArr 를다지운다.
    5) 테이블정보를리로드한다.
    */
    
    int count = selectedIndexPathArr.count;
    DataManager *dm = [DataManager singleTon_GetInstance]; 
    for(int i =0; i<count; i++)
    {
        NSPostingIndex *postingIndex = [postingIndexArr objectAtIndex:i];
        [dm deleteFile:[postingIndex getFileName]];
        
        [postingIndexArr removeObjectAtIndex:i];
    }
    
    [dm savePostingIndexToFile:postingIndexArr filename:@"posting_file_index"];

    [selectedIndexPathArr removeAllObjects];
    [savedBlogDataTableView reloadData];
}


#pragma mark PopOverMenu

-(IBAction)showMenu:(id)sender
{
    NSString *title = @"";
    if(selectedIndexPathArr.count == 0)
    {
        
        title = @"선택한 글이 없습니다.";
        menuStrArr = kNewMenuStrArr;
    }
    else if(selectedIndexPathArr.count ==1)
    {
        title = @"1개를 선택하였습니다.";
        menuStrArr= kExistMenuStrArr;
    }
    else
    {
        title = [NSString stringWithFormat:@"%d%@", selectedIndexPathArr.count, @"개를 선택하였습니다."];
        menuStrArr= kMultiExistMenuStrArr;
    }
    
    
    PopoverView *pv = [PopoverView showPopoverAtPoint:CGPointMake(300, 0)
                                               inView:self.view
                                            withTitle:title
                                      withStringArray:menuStrArr
                                             delegate:self];
}

 

#pragma mark tableview codes

//섹션과 row로 cell의 높이 설정
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int cellHeight = 60;
    return cellHeight;
}

//셀선택 해제
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [selectedIndexPathArr removeObject:indexPath];
}


//셀선택
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{     
    [selectedIndexPathArr addObject:indexPath];
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
    headerLabel.frame = CGRectMake(10.0, 20.0, 300.0, 20.0);
	
    NSString *title =
    [NSString stringWithFormat:@"%@%d%@", @"현재 ",postingIndexArr.count ,@"개의 저장중인 글이 있습니다." ];
    
    if(section == 0)
		[headerLabel setText:title];
    
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    [customView addSubview:headerLabel];
    
    //hr 이미지 
    UIImage *hrImg = [UIImage imageNamed:@"hr.png"];
    UIImageView *hrView = [[UIImageView alloc] initWithImage:hrImg];
    hrView.frame = CGRectMake(0,48, 320, 20);
    [customView addSubview: hrView];
    
    
    return customView;
    
}

//셀 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CELL";
    
    BlogPostingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[BlogPostingCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSPostingIndex *postingIndex= [postingIndexArr objectAtIndex:indexPath.row];
    
    //날짜와 타이틀.
    cell.title.text = [postingIndex getTempTitle];
    cell.date.text = [NSDateUtils getShortestDateStr:[postingIndex getCreateDate]];
    cell.week.text = [NSDateUtils getWeek:[postingIndex getCreateDate]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

//섹션내아이템이몇개?
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [postingIndexArr count];
}

//헤더 섹션의 Height 크기 설정
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
    
}




@end
