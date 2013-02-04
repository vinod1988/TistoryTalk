//
//  WritterViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 20..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "WritterViewController.h"

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
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
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
        
   
        //data reading
        
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

#pragma mark WebView



#pragma mark UIActionSheet

-(IBAction)showMenu
{
    
    UIActionSheet *popupQuery = nil;
    [self checkTempFile];
    
    if(isWritingFile == true)
    {
        popupQuery = [[UIActionSheet alloc] initWithTitle:@"글쓰기" delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:@"포스팅하기" otherButtonTitles:@"지우기", @"이어쓰기", nil];
    }
    else
    {
        popupQuery = [[UIActionSheet alloc] initWithTitle:@"글쓰기" delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:@"새 글 쓰기" otherButtonTitles: nil];
    }
    
    
    
    popupQuery.actionSheetStyle = UIBarStyleBlackTranslucent;
    
    [popupQuery showFromTabBar:self.tabBarController.tabBar];
    [popupQuery release];
    
}

-(void)checkTempFile
{
    DataManager *dm = [DataManager singleTon_GetInstance];
    NSFileManager *fileManager= [[NSFileManager alloc] init];
	
    
    
    NSArray *sortedList = [dm getDescendingFileList];
    int fileCount = [sortedList count];
    
    if (fileCount==1)
    {
        isWritingFile = true; 
    }
    else
    {
        isWritingFile = false; 
    
    }
    
    [fileManager release];
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(buttonIndex ==0 && isWritingFile == false)
    {
        //new writting
        
        MessengerViewController *messengerViewController = [[MessengerViewController alloc]init];
        [self presentViewController:messengerViewController animated:YES completion:nil];
        
        [messengerViewController release];
    }
    else if(buttonIndex ==0 && isWritingFile == true)
    {
        //posting
        
        DataManager *dm = [DataManager singleTon_GetInstance];
        TagManager *tm = [TagManager singleTon_GetInstance];
        
        NSMutableArray * blogDataFromFile = [dm getDataFromFile:@"tempBlogData"];
        
        tm.mode = @"posting";
        
        NSString* totalHtml = [tm convertHtmlDocument:blogDataFromFile];
 
    
        PostingViewController *postingViewController = [[PostingViewController alloc]init];
        
        postingViewController.content = totalHtml;
        [self presentViewController:postingViewController animated:YES completion:nil];
        
   
        [postingViewController release];
        
    }
    else if(buttonIndex ==1)
    {
        //날려버리기
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
    
    else if(buttonIndex ==2)
    {
        //이어쓰기
        MessengerViewController *messengerViewController = [[MessengerViewController alloc]init];
        
        [self presentViewController:messengerViewController animated:YES completion:nil];
        
        [messengerViewController release];
        
    }
    
}



- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    [actionSheet dismissWithClickedButtonIndex:3 animated:YES];
}



@end
