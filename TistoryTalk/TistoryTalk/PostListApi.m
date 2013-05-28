//
//  PostList.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 27..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "PostListApi.h"

@implementation PostListApi
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
    return [self getPostList:1 count:30 categoryId:@"" sort:0];
}


//sort 0 : id, 1 : date(default : 0)

-(NSMutableArray*)getPostList:(int)page count:(int)countPerPage categoryId:(NSString*)categoryId sort:(int)sort
{
    
    
    apiUrl = [apiUrl stringByAppendingFormat:@"&page=%d", page];
    apiUrl = [apiUrl stringByAppendingFormat:@"&count=%d", countPerPage];
    
    if(sort==0)
    {
        apiUrl = [apiUrl stringByAppendingString:@"&sort=id"];
    }
    else
    {
        apiUrl = [apiUrl stringByAppendingString:@"&sort=date"];
    }
    
    if(categoryId.length!=0)
    {
        apiUrl = [apiUrl stringByAppendingFormat:@"&categoryId=%@", categoryId];
    }
    
    
    NSMutableArray *postListArr  = [[NSMutableArray alloc]init];
    
    NSLog(@"apiUrl : %@", apiUrl);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:apiUrl]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSDictionary *jsonDict = nil;
    
    if (conn)
    {
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        if( [receivedData length]!=0) //if data.exist
        {
            
            NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            
            if( [receivedData length]!=0) //if data.exist
            {
                jsonDict = [receivedData objectFromJSONData];
            }
        }
    }
    
    if(jsonDict != nil)
    {
        NSDictionary* blogInfoDict = [jsonDict objectForKey:@"tistory"];
        
        int statusCode = [[blogInfoDict objectForKey:@"status"] integerValue];
        
        if(statusCode == 200)
        {
            NSDictionary *itemArr = [blogInfoDict objectForKey:@"item"];
            
            NSDictionary *posts = [itemArr objectForKey:@"posts"];
            
            
            NSArray *postArr = [posts objectForKey:@"post"];
            
            for(int i=0; i<postArr.count; i++)
            {
                NSDictionary*post = [postArr objectAtIndex:i];
                 PostListInfo *postListInfo = [[PostListInfo alloc] init];
                
                postListInfo.postId = [post objectForKey:@"id"];
                postListInfo.title = [post objectForKey:@"title"];
                postListInfo.postUrl = [post objectForKey:@"postUrl"]; 
                postListInfo.visibility = [[post objectForKey:@"visibility"] integerValue];
                postListInfo.categoryId = [post objectForKey:@"categoryId"]; 
                postListInfo.comments   = [[post objectForKey:@"comments"] integerValue];
                postListInfo.trackbacks = [[post objectForKey:@"trackbacks"] integerValue];
                 postListInfo.date = (NSDate*)[post objectForKey:@"date"];
                
                [postListArr addObject:postListInfo];
            }
        }
    }
    
    return postListArr; 
    
}
@end
