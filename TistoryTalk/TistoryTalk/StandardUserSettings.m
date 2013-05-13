//
//  StandardUserSettings.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 13..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "StandardUserSettings.h"

@implementation StandardUserSettings

+(void)setValue:(NSString*)key value:(NSString*)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getValue:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}


+(bool)exist:(NSString*)key
{
    bool isExist = NO;
    NSString * value = [self getValue:key];
    if(value != nil && value.length >0)
    {
        isExist = YES;
    }
    
    return isExist;
}
@end
