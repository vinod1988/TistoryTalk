//
//  TagManager.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 24..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "TagManager.h"

@implementation TagManager


static TagManager * singleTon = nil;


+(TagManager *)singleTon_GetInstance
{
	if(singleTon == nil)
    {
        
		singleTon = [[super allocWithZone:NULL] init];
        
    }
	return singleTon;
}


+(bool)isSigleton
{
    
    bool is_allocation = false;
    
    if(singleTon ==nil)
    {
        is_allocation = false;;
    }
    else
    {
        is_allocation = true;
    }
    
    return is_allocation;
}

+(void)destructor
{
    [singleTon release];
    singleTon = nil;
}


-(NSString*) convertHtmlDocument:(NSMutableArray*) jsonData
{
    NSString *p_stTag = @"<p>";
    NSString *p_edTag = @"</p>";
    
    NSString* totalHTMLString = [[NSString alloc] initWithFormat:@"<html>"];
    
    totalHTMLString = [totalHTMLString stringByAppendingString:@"<body style=\"border-radius: 16px; moz-border-radius: 16px; -webkit-border-radius: 16px; border: 1px dotted #807B6E; padding-left:10px; padding-top:10px;\">"];
    
    NSLog(@"Count : %d", jsonData.count);
    
    for(int i=0; i<jsonData.count; i++)
    {
        NSString *json = [jsonData objectAtIndex:i];
        NSLog(@"%@", json);
        
        NSDictionary *dictFromJson = [json objectFromJSONString];
        
        
        
        
        totalHTMLString = [totalHTMLString stringByAppendingString:p_stTag];
        
        
        NSString *text = [dictFromJson objectForKey:@"text"];
        if(text.length>0)
        {
            totalHTMLString = [totalHTMLString stringByAppendingString:[self addTagAtText:text]];
        }
        
        NSString *imageUrl =[dictFromJson objectForKey:@"imgUrl"];
        if(imageUrl.length>0)
        {
            totalHTMLString = [totalHTMLString stringByAppendingString:[self addTagAtImage:imageUrl]];
        }
         
          
        totalHTMLString = [totalHTMLString stringByAppendingString:p_edTag];
    }
    
    totalHTMLString = [totalHTMLString stringByAppendingString:@"</body>"];
    
    totalHTMLString = [totalHTMLString stringByAppendingString:@"</html>"];
    
    NSLog(@"%@",totalHTMLString);
    
    return  totalHTMLString;
    
    
}

-(NSString*) addTagAtText:(NSString*) text
{
    //TODO:
    NSString *span_stTag = @"<span style=\"font-size: 14pt; lineh-height:2\">";
    
    NSString *span_enTag = @"</span>";
    
    
    text = [span_stTag stringByAppendingString:text];
    text = [text stringByAppendingString:span_enTag];
    
    
    return text; 
}

-(NSString*) addTagAtImage:(NSString*) imgUrl
{
    //TODO:
}
@end
