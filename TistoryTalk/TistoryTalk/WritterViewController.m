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

@interface WritterViewController ()

@end

@implementation WritterViewController
@synthesize  isWritingFile, webView, noBlogData;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(removeData:) name:@"REMOVE_DATA" object:nil];
    
    
}

-(void) removeData:(NSNotification *)noti
{
    NSFileManager *fileManager= [[NSFileManager alloc] init];
    DataManager *dm = [DataManager singleTon_GetInstance];
    
    
    NSArray *sortedList = [dm getDescendingFileList];
    int fileCount = [sortedList count];
    
    if (fileCount==1)
    {
        [fileManager removeItemAtPath:[[dm getDocumentPath] stringByAppendingPathComponent:[sortedList objectAtIndex:0]] error:nil];
    }
    
    [self preview];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self preview];
}


-(void)preview
{
    [self checkTempFile];
    
    if(isWritingFile==true)
    {
        self.webView.hidden = false;
        noBlogData.hidden = true;
        
        DataManager *dm = [DataManager singleTon_GetInstance];
        TagManager *tm = [TagManager singleTon_GetInstance];
        
        NSMutableArray * blogDataFromFile = [dm getDataFromFile:@"tempBlogData"];
        tm.mode = @"preview";
        NSString* totalHtml = [tm convertHtmlDocument:blogDataFromFile];
        
        
        [webView loadHTMLString:totalHtml baseURL:nil];
        
    }
    else
    {
        self.webView.hidden = true;
        noBlogData.hidden = false;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PopOverView


-(void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%s item:%d", __PRETTY_FUNCTION__, index);
    NSString *menuStr = [menuStrArr objectAtIndex:index];
    NSLog(@"menuStr :%@", menuStr);
    // Dismiss the PopoverView after 0.5 seconds
    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    
    [self doMenu:menuStr];
}

-(void)popoverViewDidDismiss:(PopoverView *)popoverView
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
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
    MessengerViewController *messengerViewController = [[MessengerViewController alloc]init];
    messengerViewController.titleLabel.text = title;
    [self presentViewController:messengerViewController animated:YES completion:nil];
}


-(void)doPosting
{
    DataManager *dm = [DataManager singleTon_GetInstance];
    TagManager *tm = [TagManager singleTon_GetInstance];
    
    NSMutableArray * blogDataFromFile = [dm getDataFromFile:@"tempBlogData"];
    tm.mode = @"posting";
    NSString* totalHtml = [tm convertHtmlDocument:blogDataFromFile];

    PostingViewController *postingViewController = [[PostingViewController alloc]init];
    postingViewController.content = totalHtml;
    [self presentViewController:postingViewController animated:YES completion:nil];
}


-(void)doReWriting:(NSString*)title
{
    MessengerViewController *messengerViewController = [[MessengerViewController alloc]init];
    messengerViewController.titleLabel.text = title; 
    [self presentViewController:messengerViewController animated:YES completion:nil];
    
}

-(void)doDelete
{
    NSFileManager *fileManager= [[NSFileManager alloc] init];
    DataManager *dm = [DataManager singleTon_GetInstance];
    
    
    NSArray *sortedList = [dm getDescendingFileList];
    int fileCount = [sortedList count];
    
    if (fileCount==1)
    {
        [fileManager removeItemAtPath:[[dm getDocumentPath] stringByAppendingPathComponent:[sortedList objectAtIndex:0]] error:nil];
    }
    
    [self preview];

}
#pragma mark UIActionSheet

-(IBAction)showMenu:(id)sender
{
    [self checkTempFile];

    NSString *title = @"";
    if(isWritingFile == true)
    {
        title = @"이미 저장된 글이 있습니다.";
        menuStrArr= kExistMenuStrArr;
    }
    else
    {
        title = @"저장 글이 없습니다.";
        menuStrArr = kNewMenuStrArr;        
    }
    

    PopoverView *pv = [PopoverView showPopoverAtPoint:CGPointMake(300, 0)
                                               inView:self.view
                                            withTitle:title
                                      withStringArray:menuStrArr
                                             delegate:self];
}

-(void)checkTempFile
{
    DataManager *dm = [DataManager singleTon_GetInstance];
    
    NSArray *sortedList = [dm getDescendingFileList];
    int fileCount = [sortedList count];
    
    if (fileCount==1)
        isWritingFile = true;
    else
        isWritingFile = false;
    
}


@end
