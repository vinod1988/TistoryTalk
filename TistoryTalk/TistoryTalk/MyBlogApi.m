//
//  MyBlogApi.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 13..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "MyBlogApi.h"

@implementation MyBlogApi

//생성자
-(id)init
{
    if ( self = [super init] )
    {
        NSString* tistoryApiUrl = @"https:www.tistory.com/apis/";
        NSString* blogApiUrl = @"blog/info";
        NSString* output = @"output=json";
        NSString* accessToken = @"access_token";
        
        
        NSString *savedAccessToken = [StandardUserSettings getValue:TISTORY_TOKEN];
        
        
        if(savedAccessToken != nil)
        {
            apiUrl = [NSString stringWithFormat:@"%@%@?%@=%@&%@",
                      tistoryApiUrl, blogApiUrl, accessToken, savedAccessToken, output];
        }
    }
    return self;
}



-(NSMutableArray*)getMyAllBlog
{
    NSMutableArray *blogInfoArr  = [[NSMutableArray alloc]init];
    
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
            NSArray *itemArr = [blogInfoDict objectForKey:@"item"];
            
            for(int i =0; i<itemArr.count; i++)
            {
                NSDictionary* item = [itemArr objectAtIndex:i];
                
                MyBlogInfo* myBlogInfo = [[MyBlogInfo alloc]init];
                myBlogInfo.url = [item objectForKey:@"url"];
                myBlogInfo.secondaryUrl = [item objectForKey:@"secondaryUrl"];
                myBlogInfo.nickName = [item objectForKey:@"nickName"];
                myBlogInfo.description = [item objectForKey:@"description"];
                
                
                NSString *defaultStr  =  [item objectForKey:@"default"];
                
                
                if([defaultStr isEqualToString:@"Y"] || [defaultStr isEqualToString:@"y"])
                    myBlogInfo.basicBlog = YES;
                else
                    myBlogInfo.basicBlog = NO;
                
                
                myBlogInfo.blogIconUrl = [item objectForKey:@"blogIconUrl"];
                myBlogInfo.faviconUrl = [item objectForKey:@"faviconUrl"];
                myBlogInfo.profileThumbnailImageUrl = [item objectForKey:@"profileThumbnailImageUrl"];
                myBlogInfo.profileImageUrl = [item objectForKey:@"profileImageUrl"];
                myBlogInfo.pos = [[item objectForKey:@"pos"] integerValue];
                myBlogInfo.comment = [[item objectForKey:@"comment"] integerValue];
                myBlogInfo.trackback = [[item objectForKey:@"trackback"] integerValue];
                myBlogInfo.guestbook = [[item objectForKey:@"guestbook"] integerValue];
                myBlogInfo.invitation = [[item objectForKey:@"invitation"] integerValue];
                
                [blogInfoArr addObject:myBlogInfo];
                
            }
        }
    }
    
    return blogInfoArr;
}


-(MyBlogInfo*)getMyBasicBlog
{
    NSMutableArray* allBlogs = [self getMyAllBlog];
    
    MyBlogInfo* basicBlogInfo = nil;
    
    for(int i=0; i<allBlogs.count; i++)
    {
        MyBlogInfo *myBlogInfo = [allBlogs objectAtIndex:i];
        
        
        if(myBlogInfo.basicBlog)
        {
            basicBlogInfo = myBlogInfo;
            break;
        }
    }
    
    return basicBlogInfo;
}

-(NSString*)getMyBasicBlogUrl
{
    NSString*url =@"";
    MyBlogInfo*basicBlogInfo = [self getMyBasicBlog];
    
    if(basicBlogInfo.secondaryUrl ==nil || basicBlogInfo.secondaryUrl.length==7)
    {
        url = basicBlogInfo.url; 
    }
    else
    {
        url = basicBlogInfo.secondaryUrl;
        
    }
    
    
    return url;
    
}

@end
