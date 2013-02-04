//
//  PostingViewController.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 27..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPRequest.h"
#import "MyBlogInfoParser.h"
#import "CategoryParser.h"
#import "AuthViewController.h"

@interface PostingViewController : UIViewController
<UIAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource> 

{
    IBOutlet UIButton *categoryButton;
    UITextField *titleTextField;
    NSString * content;
    MyBlogInfoParser *myBlogParser;
    CategoryParser *categoryParser;
    
    NSMutableDictionary *categoryIdName;
    NSString *selectedCategoryId;
    
    UIPickerView *pickerView ;
    UIActionSheet *actionSheet;
    

}

@property(nonatomic, retain) UIButton *categoryButton;
@property(nonatomic, retain) UITextField *titleTextField;
@property(nonatomic, retain) NSString *content;
@property(nonatomic, retain) UIPickerView *pickerView ;
@property(nonatomic, retain) UIActionSheet *actionSheet;
@property(nonatomic, retain) NSString *selectedCategoryId;

-(IBAction)category:(id)sender;


@end
