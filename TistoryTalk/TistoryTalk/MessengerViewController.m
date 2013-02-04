//
//  MessengerViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 21..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "MessengerViewController.h"


@interface MessengerViewController ()

@end

@implementation MessengerViewController
@synthesize searchToolbar, mainView, currentMainView;
@synthesize leftButton, rightButton, titleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // SearchBar Setting
        searchToolbar = [[[SearchToolBar alloc]initWithFrame:CGRectMake(0, 416, 320, 44)]autorelease];
        searchToolbar.searchTextField.delegate = self;
        
        [self.view addSubview:searchToolbar];
        
        // register for keyboard notifications
        
        [[NSNotificationCenter defaultCenter] addObserver:self
         
                                                 selector:@selector(keyboardWillShow)
         
                                                     name:UIKeyboardWillShowNotification
         
                                                   object:nil];
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
         
                                                 selector:@selector(keyboardWillHide)
         
                                                     name:UIKeyboardWillHideNotification
         
                                                   object:nil];
        
        
        // BubbleData Setting
        
        bubbleData = [[NSMutableArray alloc] init];
        
        
        DataManager *dm = [DataManager singleTon_GetInstance];
        
        NSMutableArray * blogDataFromFile = [dm getDataFromFile:@"tempBlogData"];
        
        
        if(blogDataFromFile.count>0)
        {
            for(int i=0; i<blogDataFromFile.count; i++)
            {
                NSString *json = [blogDataFromFile objectAtIndex:i];
                
                NSDictionary *dictFromJson = [json objectFromJSONString];
                
                NSString *text = [dictFromJson objectForKey:@"text"];
                if(text.length>0)
                {
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyyMMdd:hh:mm:ss"];
                    NSDate *dateFromString = [[NSDate alloc] init];
                    dateFromString = [dateFormatter dateFromString:[dictFromJson objectForKey:@"date"]];
                    [dateFormatter release];
                    
                    NSInteger type = [[dictFromJson objectForKey:@"type"] intValue];
                    
                    
                    NSBubbleData *textBubble = [NSBubbleData dataWithText:text date:dateFromString type:type];
                    textBubble.avatar = nil;
                    [bubbleData addObject:textBubble];
                    
                }
                
                NSString *imageUrl =[dictFromJson objectForKey:@"imgUrl"];
                if(imageUrl.length>0)
                {
                    //                    NSBubbleData *photoBubble = [NSBubbleData dataWithImage:[UIImage imageNamed:@"halloween.jpg"] date:[NSDate dateWithTimeIntervalSinceNow:-290] type:BubbleTypeSomeoneElse];
                    //                    photoBubble.avatar = [UIImage imageNamed:@"avatar1.png"];
                    //
                    //                    totalHTMLString = [totalHTMLString stringByAppendingString:[self addTagAtImage:imageUrl]];
                }
                
            }
            
        }
        
        
        // BubbleTableView Setting
        
        bubbleTableView.bubbleDataSource = self;
        bubbleTableView.snapInterval = 120;
        bubbleTableView.showAvatars = NO;
        bubbleTableView.typingBubble = NSBubbleTypingTypeMe;
        
        
        
        // add gesture
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [bubbleTableView addGestureRecognizer:doubleTap];
        [doubleTap release];
        
        UISwipeGestureRecognizer *leftSwipegesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didLeftSwipe:)];
        leftSwipegesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [bubbleTableView addGestureRecognizer:leftSwipegesture];
        [leftSwipegesture release];
        
        UISwipeGestureRecognizer *rigthSwipegesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didRightSwipe:)];
        rigthSwipegesture.direction = UISwipeGestureRecognizerDirectionRight;
        [bubbleTableView addGestureRecognizer:rigthSwipegesture];
        [rigthSwipegesture release];
        
        //Sub Modules
        
        searchModuleView = [[[SearchModuleView alloc]initWithFrame:CGRectMake(-320,44, 320, 480-44)]autorelease];
        [self.view addSubview:searchModuleView];
        
        mapModuleView = [[[MapModuleView alloc]initWithFrame:CGRectMake(320, 44, 320,  480-44)]autorelease];
        [self.view addSubview:mapModuleView];
        
        
        
        currentMainView = MainView;
        prevNSBubbleTypingType = 1; //init
        
        

        
        [bubbleTableView reloadData];
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self registerNotificationCenter];
    
    
}

 

-(void)registerNotificationCenter
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(changeBubble:) name:@"CHANGE_BUBBLE" object:nil]; 
    [nc addObserver:self selector:@selector(closeMapModule:) name:@"MAPMODULE_CLOSE" object:nil];
    
    [nc addObserver:self selector:@selector(removeIndex:) name:@"REMOVE_INDEX" object:nil];
    
}

-(void) removeIndex:(NSNotification *)noti
{
    NSIndexPath *removeIndexPath=  [noti.userInfo objectForKey:@"removeIndex"];
    
    [bubbleData removeObjectAtIndex:removeIndexPath.row];
    [bubbleTableView reloadData];

}

-(void) closeMapModule:(NSNotification *)noti
{
    self.titleLabel.text = @"글쓰기";
    
    
     NSIndexPath *indexPath=  [noti.userInfo objectForKey:@"index"];
    
    
    if(indexPath !=nil)
    {
    KKCanididateDetail *selectedKkc = [mapModuleView.kkuCanididateArray objectAtIndex:indexPath.row];
    
    
        int currentNSBubbleTypingType = 0;
        
        if(prevNSBubbleTypingType == BubbleTypeSomeoneElse)
        {
            currentNSBubbleTypingType = BubbleTypeMine;
        }else
        {
            currentNSBubbleTypingType = BubbleTypeSomeoneElse;
        }
        
        NSString *candidateBubble = [NSString stringWithFormat:@"%@ 국회의원\n:%@\n정당:%@\n지역구:%@\n",
                                     selectedKkc.name, selectedKkc.photo, selectedKkc.political_party, selectedKkc.area];
        
        
        
        candidateBubble
        = [candidateBubble stringByAppendingFormat:@"출석수:%@\n결석수:%@\n찬성수:%@\n반대수:%@\n기권수:%@", selectedKkc.attendance, selectedKkc.absence,selectedKkc.agree, selectedKkc.opposite, selectedKkc.abstention, selectedKkc.not_vote];
        
 
        
        
        candidateBubble = [candidateBubble stringByAppendingFormat:@"\n홈페이지:%@", selectedKkc.homepage];
    
        NSBubbleData *sayBubble = [NSBubbleData dataWithText:candidateBubble date:[NSDate dateWithTimeIntervalSinceNow:0] type:currentNSBubbleTypingType];
        sayBubble.avatar = nil;
         
        
        [bubbleData addObject:sayBubble];
        
      
        prevNSBubbleTypingType = currentNSBubbleTypingType;
        
        
        [bubbleTableView reloadData];
    }
    
    

    
}

-(void) changeBubble:(NSNotification *)noti
{
    NSIndexPath *fromIndexPath =  [noti.userInfo objectForKey:@"fromIndexPath"];
    NSIndexPath *toIndexPath =  [noti.userInfo objectForKey:@"toIndexPath"];
    
    
    NSBubbleData *temp  = [[bubbleData objectAtIndex:fromIndexPath.row]retain];
    
    [bubbleData removeObjectAtIndex:fromIndexPath.row];
    [bubbleData insertObject:temp atIndex:toIndexPath.row];
    
    [temp release];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark gesture method

-(void)didDoubleTap:(UIGestureRecognizer *)gestureRecognizer
{
    
    [searchToolbar.searchTextField resignFirstResponder];
}


-(void)didLeftSwipe:(UIGestureRecognizer *)gestureRecognizer
{
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    mapModuleView.frame = CGRectMake(0,mapModuleView.frame.origin.y, mapModuleView.frame.size.width, mapModuleView.frame.size.height);
    titleLabel.text = @"Kooking";
    
    [UIView commitAnimations];
    
    // self.searchToolbar.hidden = YES;
    
    
    //    else if(currentMainView == SearchModule)
    //    {
    //
    //
    //        [UIView beginAnimations:nil context:NULL];
    //        [UIView setAnimationDuration:0.2];
    //        mainView.frame = CGRectMake(0,mainView.frame.origin.y, mainView.frame.size.width, mainView.frame.size.height);
    //        searchModuleView.frame = CGRectMake(-320,searchModuleView.frame.origin.y, searchModuleView.frame.size.width, searchModuleView.frame.size.height);
    //
    //        [UIView commitAnimations];
    //
    //        self.searchToolbar.hidden = NO;
    //        [self.view endEditing:YES];
    //
    //        currentMainView = MainView;
    //    }
    
}


-(void)didRightSwipe:(UIGestureRecognizer *)gestureRecognizer
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    // mainView.frame = CGRectMake(280,mainView.frame.origin.y, mainView.frame.size.width, mainView.frame.size.height);
    searchModuleView.frame = CGRectMake(0,searchModuleView.frame.origin.y, searchModuleView.frame.size.width, searchModuleView.frame.size.height);
    
    [UIView commitAnimations];
    
    
    
    
    //self.searchToolbar.hidden = YES;
    
    
    
    //    else if( currentMainView == MapModule)
    //    {
    //
    //        [UIView beginAnimations:nil context:NULL];
    //        [UIView setAnimationDuration:0.2];
    //        mainView.frame = CGRectMake(0,mainView.frame.origin.y, mainView.frame.size.width, mainView.frame.size.height);
    //        mapModuleView.frame = CGRectMake(320,mapModuleView.frame.origin.y, mapModuleView.frame.size.width, mapModuleView.frame.size.height);
    //
    //        [UIView commitAnimations];
    //
    //
    //        self.searchToolbar.hidden = NO;
    //        [self.view endEditing:YES];
    //
    //        currentMainView = MainView;
    //
    //    }
    
}



#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    
    return [bubbleData count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [bubbleData objectAtIndex:row];
}



#pragma mark - Keyboard action

-(void) keyboardWillShow
{
    //move keyboard up
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.searchToolbar.frame = CGRectMake(0, 200, 320, 44);
    [UIView commitAnimations];
    
    //
    bubbleTableView.frame = CGRectMake(0, bubbleTableView.frame.origin.y, 320,157);
    
}
-(void) keyboardWillHide
{
    
    //move keyboard down
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.searchToolbar.frame = CGRectMake(0, 416, 320, 44);
    [UIView commitAnimations];
    
    //
    bubbleTableView.frame = CGRectMake(0, bubbleTableView.frame.origin.y, 320,480-44-searchToolbar.frame.size.height);
    
}


#pragma mark alter action


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    
    //경고창의 타이틀을 비교해서 경고창을 구별한다.
    if ( [[alertView title] isEqualToString:@"저장할까요?"])
	{
        
        if(buttonIndex==0)
        {
            //save file using json
            
            NSMutableArray *savedJsonString = [[NSMutableArray alloc]init];
            for(int i =0;i<bubbleData.count; i++)
            {
                NSBubbleData *bbData = [bubbleData objectAtIndex:i];
                [savedJsonString addObject:[bbData toJson]];
            }
            
            
            DataManager *dm = [DataManager singleTon_GetInstance];
            [dm saveDataToFile:savedJsonString filename:@"tempBlogData"];
        }
        else
        {
            [bubbleData removeAllObjects];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
	}
	
    
	
}



#pragma mark toolbar action

-(IBAction)leftBtnClicked
{
    
    if(bubbleData.count >0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"저장할까요?" message:@"임시로 앱내에 저장됩니다." delegate:self cancelButtonTitle:@"예" otherButtonTitles:@"아니오", nil];
        alert.delegate = self;
        
        [alert show];
        [alert release];
        
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(IBAction)rightBtnClicked
{
    
    if(bubbleTableView.isEditing==YES)
    {
        [bubbleTableView setEditing:NO];
        rightButton.title = @"편집";
    }
    else
    {
        if(bubbleData.count >0)
        {
            [bubbleTableView setEditing:YES];
            
            rightButton.title = @"완료";
            rightButton.tintColor = [UIColor colorWithRed:47.0/255.0 green:155.0/255.0 blue:203.0/255.0 alpha:1.0];
            
            
        }
        else
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"데이터가 없습니다." message:@"" delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{//키보드 엔터 delegate
    
    if(textField.text.length != 0)
    {
        
        int currentNSBubbleTypingType = 0;
        
        if(prevNSBubbleTypingType == BubbleTypeSomeoneElse)
        {
            currentNSBubbleTypingType = BubbleTypeMine;
        }else
        {
            currentNSBubbleTypingType = BubbleTypeSomeoneElse;
        }
        
        NSBubbleData *sayBubble = [NSBubbleData dataWithText:textField.text date:[NSDate dateWithTimeIntervalSinceNow:0] type:currentNSBubbleTypingType];
        sayBubble.avatar = nil;
        [bubbleData addObject:sayBubble];
        
        textField.text = @"";
        prevNSBubbleTypingType = currentNSBubbleTypingType;
        
        
        [bubbleTableView reloadData];
    }
    else
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"입력해주세요" message:@"" delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    
    return true;
    
}

@end
