//
//  MyBlogInfoParser.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 2. 1..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "MyBlogInfoParser.h"

@implementation MyBlogInfoParser


-(void) requestMyBlogInfo:(NSString*)accessToken
{ 
    
    NSString*requeqtMyBlogInfoUrl = @"https://www.tistory.com/apis/blog/info?access_token=";
    requeqtMyBlogInfoUrl = [requeqtMyBlogInfoUrl stringByAppendingFormat:@"%@", accessToken];
    
    ////NSLog(@"%@", requeqtMyBlogInfoUrl);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:requeqtMyBlogInfoUrl]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    
    [request setHTTPMethod:@"GET"];
    // [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (conn)
    {
        
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receivedData];
        
        [parser setDelegate:self];
        [parser parse];
        [parser release];
        
        [conn release];
        
    }
    else
    {
    }
    
    ///
    
    
    NSString *targetUrl = @"";

    
    
    
    if([parsedMyBlogUrl2 isEqualToString:@"http://"])
    {
             
        NSArray * parsedUrl = [parsedMyBlogUrl componentsSeparatedByString:@"//"];
        
        if(parsedUrl.count==2)
        {
            NSArray * tistoryUrl = [parsedUrl[1] componentsSeparatedByString:@"."];
            targetUrl = tistoryUrl[0];
        } 
    }
    else
    {  
        if([parsedMyBlogUrl2 isEqualToString:@"http://"])
        { 
            NSArray * parsedUrl = [parsedMyBlogUrl componentsSeparatedByString:@"//"];
            
            if(parsedUrl.count==2)
            {
                NSArray * tistoryUrl = [parsedUrl[1] componentsSeparatedByString:@"."];
                targetUrl = tistoryUrl[0];
            } 
        }
        else
        {
            targetUrl = parsedMyBlogUrl2;
        }  
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:targetUrl forKey:@"my_blog"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
}


#pragma mark XMLParse delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    
    currentTagName = elementName;
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    currentTagName = [ currentTagName stringByAppendingFormat:@"</%@>",elementName ];
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"currentTag : %@ string : %@ ", currentTagName, string);
    if([currentTagName isEqualToString:@"default"])
    {
        //NSLog(@"SDFSDFSF");
        if([string isEqualToString:@"Y"])
        {
            // NSLog(@"tempP1 : %@", tempParsedMyBlogUrl);
            // NSLog(@"tempP2 : %@", tempParsedMyBlogUrl2);
            
            parsedMyBlogUrl = tempParsedMyBlogUrl;
            parsedMyBlogUrl2 = tempParsedMyBlogUrl2;
            
            //  NSLog(@"parsedMyBlogUrl : %@", parsedMyBlogUrl);
            // NSLog(@"parsedMyBlogUrl2 : %@", parsedMyBlogUrl2);
            
        }
    }
    
    if([currentTagName isEqualToString:@"url"])
    {
        
        tempParsedMyBlogUrl = [NSString stringWithString:string];
        
        // NSLog(@"t1:%@", tempParsedMyBlogUrl);
        
        
    }
    
    if([currentTagName isEqualToString:@"secondaryUrl"])
    {
        
        tempParsedMyBlogUrl2 = [NSString stringWithString:string];
        
        //  NSLog(@"t2:%@", tempParsedMyBlogUrl2);
        
    }
    
}




@end
