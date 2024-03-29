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
@synthesize searchToolbar;
@synthesize closeButton, editButton, titleLabel, bubbleTableView;


-(id)initWithFile:(NSString*)fileName
{
    if ( self = [super init] )
    {
        loadFileName = fileName;
        
        if(loadFileName !=nil)
        {
            DataManager *dm = [DataManager singleTon_GetInstance];
            posting = [dm loadPostingFromFile:loadFileName];
        }
        else
        {
            posting = [[NSPosting alloc]init];
        }
        
        [bubbleTableView reloadData];
        
        
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        // SearchBar Setting
        [self initSearchBar];
        
        
        // BubbleTableView Setting
        [self initBubbleTableView];
        
        
        // add gesture
        [self addGestures];
        
        
        [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:0/255.0 green:102/255.0 blue:153/255.0 alpha:1.0]];
        
        
        
    }
    return self;
}

-(void)initSearchBar
{//검색창에 대한 기본 설정
    searchToolbar = [[SearchToolBar alloc]initWithFrame:CGRectMake(0, 505, 320, 44)];
    searchToolbar.searchTextField.delegate = self;
    searchToolbar.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:searchToolbar];
}

-(void)initBubbleTableView
{//bubbleTableView에 대한 기본 설정
    bubbleTableView.bubbleDataSource = self;
    bubbleTableView.snapInterval = 120;
    bubbleTableView.showAvatars = NO;
    bubbleTableView.typingBubble = NSBubbleTypingTypeMe;
}

-(void)addGestures
{//현재 범위에서 국한된 모든 제스처에 대한 등록
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [bubbleTableView addGestureRecognizer:doubleTap];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerNotificationCenter];
    
    
}

-(void)registerNotificationCenter
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(changeBubble:) name:@"CHANGE_BUBBLE" object:nil];
    [nc addObserver:self selector:@selector(removeIndex:) name:@"REMOVE_INDEX" object:nil];
    [nc addObserver:self selector:@selector(showFontView:) name:@"SHOW_FONT_VIEW" object:nil];
    
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark CMTextStylePickerViewControllerDelegate methods

- (void)textStylePickerViewController:(CMTextStylePickerViewController *)textStylePickerViewController userSelectedFont:(UIFont *)font {
	//mainTextView.font = font;
}

- (void)textStylePickerViewController:(CMTextStylePickerViewController *)textStylePickerViewController userSelectedTextColor:(UIColor *)textColor {
	//mainTextView.textColor = textColor;
}

- (void)textStylePickerViewControllerSelectedCustomStyle:(CMTextStylePickerViewController *)textStylePickerViewController {
	// Use custom text style
	//mainTextView.font = textStylePickerViewController.selectedFont;
	//mainTextView.textColor = textStylePickerViewController.selectedTextColour;
}

- (void)textStylePickerViewControllerSelectedDefaultStyle:(CMTextStylePickerViewController *)textStylePickerViewController {
	// Use default text style
	//mainTextView.font = self.defaultFont;
	//mainTextView.textColor = self.defaultTextColor;
}

- (void)textStylePickerViewController:(CMTextStylePickerViewController *)textStylePickerViewController replaceDefaultStyleWithFont:(UIFont *)font textColor:(UIColor *)textColor {
	//self.defaultFont = font;
	//self.defaultTextColor = textColor;
}

- (void)textStylePickerViewControllerIsDone:(CMTextStylePickerViewController *)textStylePickerViewController
{
    
    [self setFont:textStylePickerViewController.selectedFont textColor:textStylePickerViewController.selectedTextColour];
    
	[self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)setFont:(UIFont*)font textColor:(UIColor*)textColor
{//NSFontAccessory에 폰트 정보와 텍스트 색을 지정한다.
    
    NSFontAccessory *fontAccessory =(NSFontAccessory*)[posting getAccessoryAtIndex:selectedIndexPath.row];
    
    NSMutableDictionary *decoratingDict = [[NSMutableDictionary alloc]init];
    
    [decoratingDict setObject:textColor forKey:@"TEXT_COLOR"];
    [decoratingDict setObject:font.fontName forKey:@"FONT_NAME"];
    [decoratingDict setValue:[NSNumber numberWithFloat:font.pointSize] forKey:@"FONT_SIZE"];
    
    [fontAccessory decorate:decoratingDict];
    
    
}

#pragma mark -
#pragma mark Notification Handler

-(void) showFontView:(NSNotification *)noti
{
    CMTextStylePickerViewController *textStylePickerViewController = [CMTextStylePickerViewController textStylePickerViewController];
    
	textStylePickerViewController.delegate = self;
    selectedIndexPath = [noti.userInfo objectForKey:@"SELECTED_BUBBLE"];
    
    NSString *text = (NSString*)[posting getPostingDataAtIndex:selectedIndexPath.row];
    
    NSFontAccessory *fontAccessory = (NSFontAccessory*)[posting getAccessoryAtIndex:selectedIndexPath.row];
    
    textStylePickerViewController.selectedText = [text copy];
    textStylePickerViewController.selectedFont = [fontAccessory getFont];
    textStylePickerViewController.selectedTextColour = [fontAccessory getTextColor];
    
    
    
	UINavigationController *actionsNavigationController = [[UINavigationController alloc] initWithRootViewController:textStylePickerViewController];
    
    actionsNavigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal; //회전
    [self presentViewController:actionsNavigationController animated:YES completion:nil];
    
}

-(void) removeIndex:(NSNotification *)noti
{
    NSIndexPath *removeIndexPath=  [noti.userInfo objectForKey:@"removeIndex"];
    [posting removePostingAtIndex:removeIndexPath.row];
    [posting removeAccessoryAtIndex:removeIndexPath.row];
    [bubbleTableView reloadData];
    
}

-(void) changeBubble:(NSNotification *)noti
{
    NSIndexPath *fromIndexPath =  [noti.userInfo objectForKey:@"fromIndexPath"];
    NSIndexPath *toIndexPath =  [noti.userInfo objectForKey:@"toIndexPath"];
    
    
    NSObject *tempPosing  = [posting getPostingDataAtIndex:fromIndexPath.row];
    NSAccessory *tempAccessory = [posting getAccessoryAtIndex:fromIndexPath.row];
    
    [posting removePostingAtIndex:fromIndexPath.row];
    [posting removeAccessoryAtIndex:fromIndexPath.row];
    
    [posting insertPostingData:tempPosing atIndex:toIndexPath.row];
    [posting insertAccessory:tempAccessory atIndex:toIndexPath.row];
}



#pragma mark -
#pragma mark gesture handler

-(void)didDoubleTap:(UIGestureRecognizer *)gestureRecognizer
{
    [searchToolbar.searchTextField resignFirstResponder];
}





#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [posting getPostingDataCount];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    int currentNSBubbleTypingType = BubbleTypeSomeoneElse;
    
    if(prevNSBubbleTypingType == BubbleTypeSomeoneElse)
        currentNSBubbleTypingType = BubbleTypeMine;
    else
        currentNSBubbleTypingType = BubbleTypeSomeoneElse;
    
    NSString *textPosting = (NSString*)[posting getPostingDataAtIndex:row];
    
    NSBubbleData *sayBubble = [NSBubbleData dataWithText:textPosting date:[NSDate dateWithTimeIntervalSinceNow:0] type:currentNSBubbleTypingType];
    sayBubble.avatar = nil;
    
    prevNSBubbleTypingType = currentNSBubbleTypingType;
    
    return sayBubble;
}



#pragma mark - Keyboard action

-(void) keyboardWillShow
{
    
    //move keyboard up
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.searchToolbar.frame = CGRectMake(0, 285, 320, 44); //검색창 위로 이동
    [UIView commitAnimations];
    
    bubbleTableView.frame = CGRectMake(0, bubbleTableView.frame.origin.y, 320,284-44);
    
}

-(void) keyboardWillHide
{
    
    //move keyboard down
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.searchToolbar.frame = CGRectMake(0, 505, 320, 44); //검색창 아래로 이동
    [UIView commitAnimations];
    
    bubbleTableView.frame = CGRectMake(0, bubbleTableView.frame.origin.y, 320,480-44-searchToolbar.frame.size.height);
    
}


#pragma mark UIAlterview action

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    //경고창의 타이틀을 비교해서 경고창을 구별한다.
    if ( [[alertView title] isEqualToString:@"저장할까요?"])
	{
        if(buttonIndex==0)
        {//저장,
            
            NSString* fileName =@"";
            DataManager *dm = [DataManager singleTon_GetInstance];
            
            if(loadFileName== nil)
            {
                //제일 첫 데이터를 tempTitle로 지정한다.
                [posting setTempTitle:(NSString*)[posting getPostingDataAtIndex:0]];
                
                //랜덤문자열로 파일 이름을 만든다. (확장자 미포함)
                fileName = [NSMD5Utils md5: [posting getRandomString]];
                
                //save file
                [dm savePostingToFile:posting filename:fileName];
                
                //posting index
                NSPostingIndex *postingIndex = [[NSPostingIndex alloc]init];
                [postingIndex setFileName:fileName];
                [postingIndex setTempTitle: [posting getTempTitle]];
                [postingIndex setCreateDate: [posting getCreateDate]];
                
                //notify
                NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
                [nc postNotificationName:@"NOTIFY_SAVE_POSTING" object:postingIndex userInfo:nil];
                
                
            }
            else
            {//이미 저장된 파일을 연 경우, 그 파일에 저장해야 한다.
                fileName = loadFileName;
                //save file
                [dm savePostingToFile:posting filename:fileName];
                
            }
        }
        else
        {//저장하지 않으면, 모든 데이터를 버린다.
            [posting removeAllPostings];
            [posting removeAllAccessroy];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
	}
}



#pragma mark toolbar action
-(IBAction)closeBtnClicked
{
    if([posting getPostingDataCount] >0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"저장할까요?" message:@"임시로 앱내에 저장됩니다." delegate:self cancelButtonTitle:@"예" otherButtonTitles:@"아니오", nil];
        alert.delegate = self;
        [alert show];
        
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(IBAction)editBtnClicked
{
    
    if(bubbleTableView.isEditing==YES)
    {
        [bubbleTableView setEditing:NO];
        editButton.title = @"편집";
    }
    else
    {
        if([posting getPostingDataCount] >0)
        {
            [bubbleTableView setEditing:YES];
            editButton.title = @"완료";
            editButton.tintColor = [UIColor colorWithRed:47.0/255.0 green:155.0/255.0 blue:203.0/255.0 alpha:1.0];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"데이터가 없습니다." message:@"" delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
}


#pragma mark Keyboard delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{//키보드 엔터 delegate
    
    if(textField.text.length != 0)
    {
        [posting addPostingData:textField.text];
        
        NSFontAccessory *fontAccessory
        = [[NSFontAccessory alloc]init];
        
        NSMutableDictionary *mutableDict =
        [[NSMutableDictionary alloc]init];
        
        UIFont *defaultFont = [UIFont systemFontOfSize:9.0f];
        [mutableDict setObject:[UIColor blackColor] forKey:@"TEXT_COLOR"];
        [mutableDict setObject:defaultFont.fontName forKey:@"FONT_NAME"];
        [mutableDict setValue:[NSNumber numberWithFloat:defaultFont.pointSize] forKey:@"FONT_SIZE"];
        
        [fontAccessory decorate:mutableDict];
        [posting addAccessory:fontAccessory];
        
        textField.text = @"";
        prevNSBubbleTypingType = 1;
        [bubbleTableView reloadData];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"입력해주세요" message:@"" delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    return true;
}

@end
