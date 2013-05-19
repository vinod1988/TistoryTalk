//
//  TistoryHtmlTagManager.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 18..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "TistoryHtmlTagManager.h"

@implementation TistoryHtmlTagManager


static TistoryHtmlTagManager * singleTon = nil;


+(TistoryHtmlTagManager *)singleTon_GetInstance
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



-(NSString*) convertHtmlDocument:(NSMutableArray*) postingData
{
    NSString *p_stTag = @"<p style=\"lineh-height:2; ";
    p_stTag = [ p_stTag stringByAppendingFormat:@"%@",@"text-align:justify;\">"];
    
    
    
    NSString *p_edTag = @"</p>";
    
    NSString* totalHTMLString = [[NSString alloc] initWithFormat:@"<html>"];
    totalHTMLString = [totalHTMLString stringByAppendingString:@"<body>"];
     
    for(int i=0; i<postingData.count; i++)
    { 
        
        totalHTMLString = [totalHTMLString stringByAppendingString:p_stTag];
        
        NSString *text = [postingData objectAtIndex:i];
        
        
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
                    NSString *tt = [textNewLine objectAtIndex:j]; 
                    totalHTMLString = [totalHTMLString stringByAppendingString:[self addTagAtText:tt]]; 
                    totalHTMLString = [totalHTMLString stringByAppendingFormat:@"%@", @"<br/>"]; 
                } 
            }
        }
        
        totalHTMLString = [totalHTMLString stringByAppendingString:p_edTag];
    }
    
    totalHTMLString = [totalHTMLString stringByAppendingString:@"</body>"];
    totalHTMLString = [totalHTMLString stringByAppendingString:@"</html>"];
    
    return  totalHTMLString; 
}



-(NSString*) addTagAtText:(NSString*) text
{
    NSString *span_stTag = @"<span style=\"font-size:";
    span_stTag = [span_stTag stringByAppendingFormat:@"%@",@"11pt; line-height:2;\">"];
    
    NSString *span_enTag = @"</span>";
    text = [span_stTag stringByAppendingString:text];
    text = [text stringByAppendingString:span_enTag];
    
    return text;
}



@end
