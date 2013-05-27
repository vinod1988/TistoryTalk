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
    fontName  = [objects objectForKey:@"FONT_NAME"];
    fontSize  = [[objects objectForKey:@"FONT_SIZE"] intValue];
}

   

-(UIFont*)getFont
{
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    return font; 
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
    [aCoder encodeObject:fontName forKey:@"fontName"];
    [aCoder encodeInt32:fontSize forKey:@"fontSize"];
}

// 디코딩. 디코딩시 디코더가 이 메소드를 호출한다.
-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        textColor        = [aDecoder decodeObjectForKey:@"textColor"];
        fontName  = [aDecoder decodeObjectForKey:@"fontName"];
        fontSize = [aDecoder decodeInt32ForKey:@"fontSize"];
    }
    
    return self;
}

@end
