//
//  SwitchCell.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 14..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell
@synthesize title, switchValue;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
		title = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 6.0, 100.0, 30.0)];
        
        switchValue = [[UISwitch alloc] initWithFrame:CGRectMake(210, 7.0, 100.0, 30.0)];
        [switchValue addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
		
        UIFont *desc_Font = [UIFont fontWithName:@"Helvetica" size:13];
		title.font = desc_Font;
		
        //글자색 변경
		title.textColor = [UIColor colorWithRed:51/255.0 green:102/255.0 blue:153/255.0 alpha:1.0];
        
		[self addSubview:title];
        [self addSubview:switchValue];
        
        
        [self.backgroundView setHidden:YES];
        self.backgroundColor = [UIColor whiteColor];
        self.opaque = NO;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}




//스위치 값이 바뀔때마다 실행 매서드
-(void)switchAction:(UISwitch *)tempSwitch
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    
    if (tempSwitch.on)
    {  
        [nc postNotificationName:@"NOTIFY_LOGIN_SWITCH_ON" object:nil userInfo:nil];
    }
    else
    {  
        
        [nc postNotificationName:@"NOTIFY_LOGIN_SWITCH_OFF" object:nil userInfo:nil];
    }
}



@end
