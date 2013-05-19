//
//  WriteApi.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 19..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "WriteApi.h"

@implementation WriteApi
//생성자
-(id)init
{
    if ( self = [super init] )
    {
    }
    return self;
}

-(void)post:(NSString*)title tags:(NSString*)tag categoryID:(NSString*)categoryID content:(NSString*)content
{ // 접속할 주소 설정
	NSString *url = @"https://www.tistory.com/apis/post/write";
	
    
    // HTTP Request 인스턴스 생성
    HTTPRequest *httpRequest = [[HTTPRequest alloc] init];
    
    // POST로 전송할 데이터 설정
    NSMutableDictionary *bodyObject = [[NSMutableDictionary alloc]init];
    
    
    NSString *savedAccessToken = [StandardUserSettings getValue:TISTORY_TOKEN];
    NSString *targetUrl = [ApiUtils getTargetUrl];
    NSString *visibility = @"3"; //발행.
    
    [bodyObject setValue:savedAccessToken forKey:@"access_token"];
    [bodyObject setValue:targetUrl forKey:@"targetUrl"];
    [bodyObject setValue:categoryID forKey:@"category"];
    [bodyObject setValue:title forKey:@"title"];
    [bodyObject setValue:content forKey:@"content"];
    [bodyObject setValue:tag forKey:@"tag"];
    [bodyObject setValue:visibility forKey:@"visibility"];
    
    [bodyObject setValue:@"json" forKey:@"output"];
    
    
    // 통신 완료 후 호출할 델리게이트 셀렉터 설정
    [httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
    
    // 페이지 호출
    bool isRequested = [httpRequest requestUrl:url bodyObject:bodyObject];
    
    if(!isRequested)
    {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"NOTIFY_POST_FAIL" object:nil userInfo:nil];
        
    }
    
}

-(void)didReceiveFinished:(id)sender
{
    NSString* receivedData = (NSString*)sender;
    NSDictionary *jsonDict = [receivedData objectFromJSONString];
    
    NSDictionary* result = [jsonDict objectForKey:@"tistory"];
    
    
    int status = [[result objectForKey:@"status"] integerValue];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
     
    
    if(status==200)
        [nc postNotificationName:@"NOTIFY_POST_SUCCESS" object:nil userInfo:nil];
    else
        [nc postNotificationName:@"NOTIFY_POST_FAIL" object:nil userInfo:nil];
    
}



@end
