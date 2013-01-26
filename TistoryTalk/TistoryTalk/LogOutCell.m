//
//  LogOutCell.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 21..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "LogOutCell.h"

@implementation LogOutCell



@synthesize title, onOff;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
		title = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 6.0, 100.0, 30.0)];
		onOff = [[UISwitch alloc] initWithFrame:CGRectMake(120.0, 7.0, 180.0, 30.0)]; 
        [onOff addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
		
        UIFont *desc_Font = [UIFont fontWithName:@"Helvetica" size:13];
		title.font = desc_Font;
        
        //글자색 변경
		title.textColor = [UIColor colorWithRed:51/255.0 green:102/255.0 blue:153/255.0 alpha:1.0];
        
		[self addSubview:title];
		[self addSubview:onOff];
        
        
        [self.backgroundView setHidden:YES];
        self.backgroundColor = [UIColor whiteColor];
        self.opaque = NO;
        
        
    }
    return self;
}

-(void)switchAction:(UISwitch *)onoffSwitch
{//실제 UISwitch 이벤트 받는 부분 코드 
    
    if (onoffSwitch.on)
    {
        NSLog(@"Switch ON");
    }
    else
    {
        NSLog(@"Switch OFF");
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (void)dealloc
{
	[title release];
	[onOff release];
	
    [super dealloc];
}




@end
