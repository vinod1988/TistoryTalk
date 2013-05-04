
//
//  TistoryAuth.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 3..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//


#define TISTORY_TOKEN @"tistory_token"
#import "TistoryAuth.h"


@implementation TistoryAuth


+(void)setToken:(NSString*)token
{
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:TISTORY_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];

}


+(NSString*)getToken
{
   return [[NSUserDefaults standardUserDefaults] stringForKey:TISTORY_TOKEN];
    
}


+(bool)exist
{
    bool isExist = NO;
    NSString * token = [self getToken];
    if(token != nil && token.length >0)
    {
        isExist = YES;
    }
    
    return isExist; 
    
}
@end
