//
//  TagInputViewController.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 18..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "TagInputViewController.h"

@interface TagInputViewController ()

@end

@implementation TagInputViewController
@synthesize tagTableView; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        UIView *tagView = [[UIView alloc]initWithFrame:CGRectMake(20, 44, 280, 60)];
        tagView.layer.borderColor = [UIColor grayColor].CGColor;
        tagView.layer.borderWidth = 0.5f;
        tagView.backgroundColor = [UIColor whiteColor];
        [[tagView layer] setCornerRadius:8];
        
        tagTextField = [[UITextField alloc]initWithFrame:CGRectMake(10,10,260,40)];
        tagTextField.delegate = self; 
        tagTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        tagTextField.borderStyle = UITextBorderStyleNone;
        tagTextField.backgroundColor= [UIColor whiteColor];
        [tagView addSubview:tagTextField];
        
        [self.view addSubview:tagView];

        
        
        UIBarButtonItem *nextBtn = [[UIBarButtonItem alloc] initWithTitle:@"다음" style:UIBarButtonItemStyleBordered target:self action:@selector(next:)];
        nextBtn.tintColor =[UIColor colorWithRed:0/255.0 green:102/255.0 blue:153/255.0 alpha:1.0];
        self.navigationItem.rightBarButtonItem = nextBtn;
        
        UIBarButtonItem *cancleBtn = [[UIBarButtonItem alloc] initWithTitle:@"취소" style:UIBarButtonItemStyleBordered target:self action:@selector(close:)];
        cancleBtn.tintColor =[UIColor colorWithRed:0/255.0 green:102/255.0 blue:153/255.0 alpha:1.0];
        
        self.navigationItem.leftBarButtonItem = cancleBtn;
        self.title = @"태그입력";
        
        [self addGestures];
        
        [tagTextField becomeFirstResponder];
        
    }
    return self;
}

-(void)addGestures
{//현재 범위에서 국한된 모든 제스처에 대한 등록
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tagArr = [[NSMutableArray alloc]init];

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

-(IBAction)next:(id)sender
{
    self.postingUpload.tags = [self getTotalTagStr];
    CategoryInputViewController *categoryInputViewController = [[CategoryInputViewController alloc]init];
    categoryInputViewController.postingUpload = self.postingUpload; 
    [self.navigationController pushViewController:categoryInputViewController animated:YES];
}


-(NSString*)getTotalTagStr
{
    NSMutableString* tagStr = [[NSMutableString alloc]init];
    
    for(int i =0; i<tagArr.count; i++)
    {
        if(i!=tagArr.count-1)
        {
            [tagStr appendFormat:@"%@,", [tagArr objectAtIndex:i]];
        }
        else
        {
            [tagStr appendFormat:@"%@", [tagArr objectAtIndex:i]];
        }
    }
    
    
    return tagStr; 
}

#pragma mark gesture handler

-(void)didDoubleTap:(UIGestureRecognizer *)gestureRecognizer
{
    [tagTextField resignFirstResponder];
}



#pragma mark tableview codes
// (-)눌렀을때, delete 대신에 나오게 하는 문구 지정.
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"삭제";
}


//UITableViewCellEditingStyle 에따라다르게반응시키기, 삽입혹은삭제
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tagArr removeObjectAtIndex:indexPath.row];
        [tagTableView reloadData];
    }
}

//섹션과 row로 cell의 높이 설정
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int cellHeight = 40;
    return cellHeight;
}



//셀선택
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//셀 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = (NSString*)[tagArr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//섹션내아이템이몇개?
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tagArr.count;
}


#pragma mark textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [tagArr addObject:textField.text];
    textField.text = @"";
    [tagTableView reloadData];
    return YES; 
}
 



@end
