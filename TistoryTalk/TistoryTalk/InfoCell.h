//
//  CustomCell_Label.h
//  Hanwoo
//
//  Created by 성현 안 on 11. 2. 13..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
 

@interface InfoCell : UITableViewCell
{
	
	  UILabel *title;
	  UILabel *value; 
}


@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *value;


@end
