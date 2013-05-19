//
//  PostingViewController.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 27..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "HTTPRequest.h" 
#import "AuthViewController.h"
#import "TagInputViewController.h"
#import "NSPostingUpload.h"


@interface PostingViewController : UIViewController
{
 
    UITextField *titleTextField;
    NSString * content; 
    

}
 
@property(nonatomic, strong) UITextField *titleTextField;
@property(nonatomic, readwrite) NSPostingUpload *postingUpload; 
 

-(id)initWithPostingTitle:(NSString*)_postingTitle;

@end
