//
//  NSFontAccessory.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 26..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSAccessory.h"

@interface NSFontAccessory : NSAccessory
<NSCoding>
{
    UIColor *textColor;
    UIFont *textFont;
}

-(UIFont*)getFont;
-(UIColor*)getTextColor;
-(void) setFont:(UIFont*)font;  

-(void) setTextColor:(UIColor*)color;
@end
