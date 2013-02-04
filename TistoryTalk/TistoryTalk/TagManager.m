//
//  TagManager.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 24..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "TagManager.h"

@implementation TagManager
@synthesize mode;


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
    NSString *p_stTag = @"<p style=\"lineh-height:2; ";
 
    if([mode isEqualToString:@"preview"])
    {
        p_stTag = [p_stTag stringByAppendingFormat:@"%@",@"\">"];
    }
    else
    {
        
        p_stTag = [ p_stTag stringByAppendingFormat:@"%@",@"text-align:justify;\">"];

    }
    
    
    NSString *p_edTag = @"</p>";
    
    NSString* totalHTMLString = [[NSString alloc] initWithFormat:@"<html>"];
    
    if([mode isEqualToString:@"preview"])
    {
        totalHTMLString = [totalHTMLString stringByAppendingString:@"<body style=\"border-radius: 10px; moz-border-radius: 10px; -webkit-border-radius: 10px; border: 1px dotted #807B6E; padding-left:10px; padding-top:10px; padding-bottom:10px; padding-right:10px;\">"];
    }
    else
    {
        totalHTMLString = [totalHTMLString stringByAppendingString:@"<body>"];
    }
    
    //TODO : MODE에 따라서  BODY STYLE 따로 해야하고, BODY 부분도 다른 함수로 해서 태그 붙이는 부분 분리한다.
    
    for(int i=0; i<jsonData.count; i++)
    {
        NSString *json = [jsonData objectAtIndex:i];
        
        NSDictionary *dictFromJson = [json objectFromJSONString];
        
        totalHTMLString = [totalHTMLString stringByAppendingString:p_stTag];
        
        
        NSString *text = [dictFromJson objectForKey:@"text"];
        
        
        if(text.length>0)
        {
         
            NSArray * textNewLine = [text componentsSeparatedByString:@"\n"];

            if(textNewLine.count==0)
            {
            
              totalHTMLString = [totalHTMLString stringByAppendingString:[self addTagAtText:text]];
            }
            else
            {
                
                for(int j=0; j<textNewLine.count; j++)
                {
                    NSString *tt =  [textNewLine objectAtIndex:j];
                                    
                    NSRange jpgRange = [tt rangeOfString:@".jpg"];
                    if (jpgRange.location == NSNotFound)
                    {
                        
                        NSRange pngRange = [tt rangeOfString:@".png"];
                        if (pngRange.location == NSNotFound)
                        {
                            totalHTMLString = [totalHTMLString stringByAppendingString:[self addTagAtText:tt]];
                            
                        }
                        else{
                        totalHTMLString = [totalHTMLString stringByAppendingString:[self addTagAtText:tt]];
                        }

                    }
                    else
                    {//iMAGE TAG
                        
                        totalHTMLString = [totalHTMLString stringByAppendingString:[self addTagAtImage:[tt substringFromIndex:1]]];

                    }
                    
               
    /*
                    NSRange linkRange = [tt rangeOfString:@"홈페이지"];
                    if (linkRange.location == NSNotFound)
                    {
                        totalHTMLString = [totalHTMLString stringByAppendingString:[self addTagAtText:tt]];
                        
                    }
                    else
                    {//link TAG
                        
                        totalHTMLString = [totalHTMLString stringByAppendingString:[self addTagAtLink:tt ]];
                        
                    }
     */
                    
                    totalHTMLString = [totalHTMLString stringByAppendingFormat:@"%@", @"<br/>"];
                }
            //totalHTMLString = [totalHTMLString stringByAppendingFormat:@"%@", @"<hr/>"];

            
                
                
            }
        }
        
//        NSString *imageUrl =[dictFromJson objectForKey:@"imgUrl"];
//        if(imageUrl.length>0)
//        {
//            totalHTMLString = [totalHTMLString stringByAppendingString:[self addTagAtImage:imageUrl]];
//        }
        
        
        totalHTMLString = [totalHTMLString stringByAppendingString:p_edTag];
    }
    
    totalHTMLString = [totalHTMLString stringByAppendingString:@"</body>"];
    
    totalHTMLString = [totalHTMLString stringByAppendingString:@"</html>"];
    
    //NSLog(@"%@",totalHTMLString);
    
    return  totalHTMLString;
    
    
}

-(NSString*) addTagAtText:(NSString*) text
{
    
    NSString *span_stTag = @"<span style=\"font-size:";
 
    if([mode isEqualToString:@"preview"])
    {
        
        span_stTag = [span_stTag stringByAppendingFormat:@"%@",@"12px; line-height:2;\">"];
        
    }else
    {
        span_stTag = [span_stTag stringByAppendingFormat:@"%@",@"11pt; line-height:2;\">"];
    }
    
    NSString *span_enTag = @"</span>";
    
    
    text = [span_stTag stringByAppendingString:text];
    text = [text stringByAppendingString:span_enTag];
    
    
    return text;
}

-(NSString*) addTagAtImage:(NSString*) imgUrl
{
     

    /* <img src="asdfas" width="" height=""/> */ 
    NSString *span_stTag = @"<img src=\"";
    
    if([mode isEqualToString:@"preview"])
    {
        
        span_stTag = [span_stTag stringByAppendingFormat:@"%@\" width=\"100\" height=\"120\"",imgUrl];
    }else
    {
        span_stTag = [span_stTag stringByAppendingFormat:@"%@\"",imgUrl];

    }
    
    NSString *span_enTag = @"/>";
    
     
    NSString *imgTag= [NSString stringWithFormat:@"%@%@", span_stTag, span_enTag];
    
    NSLog(@"img tag : %@", imgTag);
    
    
    return imgTag;
}


-(NSString*) addTagAtLink:(NSString*) linkUrl
{
     
    
    NSArray * splitted = [linkUrl componentsSeparatedByString:@":"];

    
    
    NSString *span_stTag = @"홈페이지:<link href=\"";
    
    
        
    span_stTag = [span_stTag stringByAppendingFormat:@"%@", [splitted objectAtIndex:1]];
    
    
    NSString *span_enTag = @"\"/>";
    
    
    NSString *linkTag= [NSString stringWithFormat:@"%@%@", span_stTag, span_enTag];
    
    return linkTag;
}

@end
