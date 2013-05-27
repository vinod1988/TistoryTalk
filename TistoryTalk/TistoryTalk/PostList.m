//
//  PostList.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 27..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "PostList.h"

@implementation PostList
//생성자
-(id)init
{
    if ( self = [super init] )
    {
        NSString* tistoryApiUrl = @"https:www.tistory.com/apis/";
        NSString* postApiUrl = @"post/list";
        NSString* output = @"output=json";
        NSString* accessToken = @"access_token";
        NSString* targetUrl = @"targetUrl";
        
        
        NSString *savedAccessToken = [StandardUserSettings getValue:TISTORY_TOKEN];
        
        
        if(savedAccessToken != nil)
        {
            apiUrl = [NSString stringWithFormat:@"%@%@?%@=%@&%@=%@&%@",
                      tistoryApiUrl, postApiUrl, accessToken, savedAccessToken,
                      targetUrl, [ApiUtils getTargetUrl], output];
            
            
        }
    }
    return self;
}



-(NSMutableArray*)getDefaultPostList
{
    return [self getPostList:1 count:30 categoryId:nil sort:0];
}


//sort 0 : id, 1 : date(default : 0)

-(NSMutableArray*)getPostList:(int)page count:(int)countPerPage categoryId:(NSString*)categoryId sort:(int)sort
{
    
}
@end
