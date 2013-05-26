//
//  NSFontAccessory.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 26..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "NSFontAccessory.h"

@implementation NSFontAccessory 


-(void)decorate:(NSDictionary*)objects
{

    textColor = [objects objectForKey:@"TEXT_COLOR"];
    textFont  = [objects objectForKey:@"TEXT_FONT"];
}

-(void) setFont:(UIFont*)font
{
    textFont = font;
}

-(void) setTextColor:(UIColor*)color
{
    textColor = color;
}

-(UIFont*)getFont
{
    return textFont;
}

-(UIColor*)getTextColor
{
    return textColor; 
}

#pragma mark NSCoding
// 인코딩. 인코딩시 인코더가 이 메소드를 호출한다.
-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:textColor  forKey:@"textColor"];
    [aCoder encodeObject:textFont forKey:@"textFont"]; 
    
}

// 디코딩. 디코딩시 디코더가 이 메소드를 호출한다.
-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        textColor        = [aDecoder decodeObjectForKey:@"textColor"];
        textFont  = [aDecoder decodeObjectForKey:@"textFont"]; 
    }
    
    return self;
}

@end
