//
//  PostReadApi.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 29..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "PostReadApi.h"

@implementation PostReadApi
//생성자
-(id)init
{
    if ( self = [super init] )
    {
        NSString* tistoryApiUrl = @"https:www.tistory.com/apis/";
        NSString* postReadApiUrl = @"post/read";
        NSString* output = @"output=json";
        NSString* accessToken = @"access_token";
        NSString* targetUrl = @"targetUrl";
        
        
        NSString *savedAccessToken = [StandardUserSettings getValue:TISTORY_TOKEN];
        
        
        if(savedAccessToken != nil)
        {
            apiUrl = [NSString stringWithFormat:@"%@%@?%@=%@&%@=%@&%@",
                      tistoryApiUrl, postReadApiUrl, accessToken, savedAccessToken,
                      targetUrl, [ApiUtils getTargetUrl], output];
            
            
        }
    }
    return self;
}

-(PostInfo*)getPostInfo:(NSString*) postId
{
    
    apiUrl = [apiUrl stringByAppendingFormat:@"&postId=%@", postId];
    
    
    PostInfo *postInfo = [[PostInfo alloc] init];
    
    
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
            
            
            postInfo.postId = [itemArr objectForKey:@"id"];
            postInfo.title = [itemArr objectForKey:@"title"];
            postInfo.content= [itemArr objectForKey:@"content"];
            postInfo.categoryId = [itemArr objectForKey:@"categoryId"];
            postInfo.postUrl = [itemArr objectForKey:@"postUrl"];
            postInfo.visibility = [[itemArr objectForKey:@"visibility"]integerValue];
            postInfo.acceptComment = [[itemArr objectForKey:@"acceptComment"] integerValue];
            postInfo.acceptTrackback = [[itemArr objectForKey:@"acceptTrackback"] integerValue];
            postInfo.comments = [[itemArr objectForKey:@"comments"] integerValue];
            postInfo.trackbacks = [[itemArr objectForKey:@"trackbacks"] integerValue];
            postInfo.date = (NSDate*)[itemArr objectForKey:@"date"];
            
        }
    }
    
    return postInfo;
}
@end
