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


@end
