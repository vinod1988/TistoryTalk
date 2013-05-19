//
//  ApiUtils.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 19..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "ApiUtils.h"

@implementation ApiUtils
+(NSString*)getTargetUrl
{
    NSString *myblogAddr = [StandardUserSettings getValue:MY_BLOG_ADDR];
    
    NSString *targetUrl = @"";
    
    NSRange aRange = [myblogAddr rangeOfString:@"tistory.com"];
    if (aRange.location == NSNotFound)
    {//2차 도메인
        
        NSArray * blogAddrArr = [myblogAddr componentsSeparatedByString:@"://"];
        targetUrl = blogAddrArr[1];
        
    }
    else
    {//1차 도메인
        
        NSArray * blogAddrArr = [myblogAddr componentsSeparatedByString:@"."];
        targetUrl = blogAddrArr[0];
        targetUrl = [targetUrl componentsSeparatedByString:@"://"][1];
        
    }
    
    return targetUrl;
}
@end
