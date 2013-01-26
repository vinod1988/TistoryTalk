//
//  CustomCell_Label.m
//  Hanwoo
//
//  Created by 성현 안 on 11. 2. 13..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoCell.h"


@implementation InfoCell


@synthesize title, value;
 

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		
		title = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 6.0, 100.0, 30.0)];
		value = [[UILabel alloc] initWithFrame:CGRectMake(120.0, 6.0, 180.0, 30.0)];
		
        UIFont *desc_Font = [UIFont fontWithName:@"Helvetica" size:13];
		title.font = desc_Font;	
		value.font = desc_Font;
		
        //글자색 변경
		title.textColor = [UIColor colorWithRed:51/255.0 green:102/255.0 blue:153/255.0 alpha:1.0];

		[self addSubview:title];
		[self addSubview:value];
        
        
        [self.backgroundView setHidden:YES];
        self.backgroundColor = [UIColor whiteColor];
        self.opaque = NO;
        
        
        
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:animated]; 
}


- (void)dealloc
{ 	
	[title release]; 
	[value release]; 
	
    [super dealloc];
}



@end
