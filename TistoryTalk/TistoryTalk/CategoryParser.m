//
//  CategoryParser.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 2. 1..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "CategoryParser.h"

@implementation CategoryParser

-(id)init
{
    
    if ( self = [super init] )
    {
        categoryId = [[NSMutableArray alloc]init];
        categoryName = [[NSMutableArray alloc]init];
        
        
    }
    return self;
    
    
}

-(NSMutableDictionary*) requestCategory
{
    
    [categoryId removeAllObjects];
    [categoryName removeAllObjects];
    
    
    NSString *requestCategoryUrl = @"https://www.tistory.com/apis/category/list?";
    
    NSString* access_token = [[NSUserDefaults standardUserDefaults] stringForKey:@"tistory_token"];
    NSString* targetUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"my_blog"];
    
    requestCategoryUrl = [requestCategoryUrl stringByAppendingFormat:@"%@%@&", @"access_token=",access_token];
    requestCategoryUrl = [requestCategoryUrl stringByAppendingFormat:@"%@%@", @"targetUrl=",targetUrl];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:requestCategoryUrl]
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
    
    //
    
    
    NSMutableDictionary *idNameDict = [[NSMutableDictionary alloc] init];
    NSLog(@"COUNT : %d", categoryId.count);
    
 
    
    for(int i =0; i<categoryId.count; i++)
    {
        [idNameDict setObject:[NSString stringWithFormat:@"%@??%@", [categoryId objectAtIndex:i], [categoryName objectAtIndex:i]]
                       forKey:[NSString stringWithFormat:@"%d", i ]];
        
        NSLog(@"%@", [idNameDict objectForKey:[NSString stringWithFormat:@"%d", i]]);
    }
    
    
    
    return idNameDict;
    
    
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
    
    //TODO: ACCESS_TOKEN 처리
    
    NSLog(@"raw : %@", string);
    
    if([currentTagName isEqualToString:@"id"])
    {
        
        NSLog(@"id : %@", string);
        
        
        [categoryId addObject:[NSString stringWithString:string]];
        
        
    }
    
    if([currentTagName isEqualToString:@"name"])
    {
        
        NSLog(@"name : %@", string);
        
        
        [categoryName addObject:[NSString stringWithString:string]];
        
    }
    
    
}


@end
