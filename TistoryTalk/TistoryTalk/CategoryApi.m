//
//  CategoryApi.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 19..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "CategoryApi.h"

@implementation CategoryApi
//생성자
-(id)init
{
    if ( self = [super init] )
    {
        NSString* tistoryApiUrl = @"https:www.tistory.com/apis/";
        NSString* blogApiUrl = @"category/list";
        NSString* output = @"output=json";
        NSString* accessToken = @"access_token";
        NSString* targetUrl = @"targetUrl";
        
        
        NSString *savedAccessToken = [StandardUserSettings getValue:TISTORY_TOKEN];
        
        
        if(savedAccessToken != nil)
        {
            apiUrl = [NSString stringWithFormat:@"%@%@?%@=%@&%@=%@&%@",
                      tistoryApiUrl, blogApiUrl, accessToken, savedAccessToken,
                      targetUrl, [ApiUtils getTargetUrl], output];
            
            //NSLog(@"api url : %@", apiUrl);
        }
    }
    return self;
}

 


-(NSMutableArray*)getAllCategory
{
    NSMutableArray *categoryInfoArr  = [[NSMutableArray alloc]init];
    
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
            //NSLog(@"200");
            NSDictionary *itemArr = [blogInfoDict objectForKey:@"item"];
           // NSLog(@"itemArr.count :%d", itemArr.count);
            
            NSDictionary *categories = [itemArr objectForKey:@"categories"];
            
            
            NSArray *categoryArr = [categories objectForKey:@"category"];
            
            
           // NSLog(@"categoryArr : %d", categoryArr.count);
            
            for(int i=0; i<categoryArr.count; i++)
            {
                NSDictionary*category = [categoryArr objectAtIndex:i];
                CategoryInfo *catInfo = [[CategoryInfo alloc] init];
                
                catInfo.categoryId = [category objectForKey:@"id"];
                catInfo.name = [category objectForKey:@"name"];
                catInfo.parent = [category objectForKey:@"parent"];
                catInfo.label = [category objectForKey:@"label"];
                catInfo.entries = [[category objectForKey:@"entries"] integerValue];
                catInfo.entriesInLogin = [[category objectForKey:@"entriesInLogin"]integerValue];
                
                [categoryInfoArr addObject:catInfo];
                
            }
            
        }
    }
    
    return categoryInfoArr;
    
}





@end
