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



-(NSString*) convertHtmlDocument:(NSMutableArray*)postingData accessory:(NSMutableArray*)postingAccessory
{
    NSString *p_stTag = @"";
    NSString *p_endTag = @"";
    
    //html, body 태그 열기
    NSString* totalHTMLString = [[NSString alloc] initWithFormat:@"<html>"];
    totalHTMLString = [totalHTMLString stringByAppendingString:@"<body>"];
    
    for(int i=0; i<postingData.count; i++)
    {
        //하나의 글문단은 <p> ~ </p>로 묶인다.
         
        p_stTag = @"<p style=\"lineh-height:2;text-align:justify;\">";
        p_endTag = @"</p>";
        
        totalHTMLString = [totalHTMLString stringByAppendingString:p_stTag];
        
        
        
        NSString *text = [postingData objectAtIndex:i];
        
        NSFontAccessory *fontAccessoryAtIndex = [postingAccessory objectAtIndex:i];
        
        if(text.length>0)
        {
            
            NSArray * textNewLine = [text componentsSeparatedByString:@"\n"];
            
            if(textNewLine.count==0)
            {//하나의 문단안에 하나의 문장만 있는 경우 
                totalHTMLString = [totalHTMLString stringByAppendingString:[self addSpanTagAtText:text fontAccessory:fontAccessoryAtIndex]];
            }
            else
            {//하나의 문단안에 여러개의 문장(newline) 이 있는 경우,
                for(int j=0; j<textNewLine.count; j++)
                {
                    NSString *tt = [textNewLine objectAtIndex:j];
                    totalHTMLString = [totalHTMLString stringByAppendingString:[self addSpanTagAtText:tt fontAccessory:fontAccessoryAtIndex]];
                    totalHTMLString = [totalHTMLString stringByAppendingFormat:@"%@", @"<br/>"];
                }
            }
        }
        
        totalHTMLString = [totalHTMLString stringByAppendingString:p_endTag];
    }
    
    
    //body, html 태그 닫기 
    totalHTMLString = [totalHTMLString stringByAppendingString:@"</body>"];
    totalHTMLString = [totalHTMLString stringByAppendingString:@"</html>"];
    
    return  totalHTMLString;
}



-(NSString*) addSpanTagAtText:(NSString*)text fontAccessory:(NSFontAccessory*)fontAccessory
{//<span> 태그를 만드는 부분. NSFontAccessory에 대한 부분에서 가져와서 추가해 준다. 
    
    
    NSString *span_stTag = @"<span style=\"";
     
    span_stTag = [span_stTag stringByAppendingFormat:@"font-family:%@;",[fontAccessory getFont].fontName];
    span_stTag = [span_stTag stringByAppendingFormat:@"font-size:%dpt;",(int)([fontAccessory getFont].pointSize)];
    span_stTag = [span_stTag stringByAppendingFormat:@"color:%@;",[NSColor colorToHexString:[fontAccessory getTextColor]]];
    span_stTag = [span_stTag stringByAppendingFormat:@"%@", @"\">"];
    
    
    NSString *span_enTag = @"</span>";
    text = [span_stTag stringByAppendingString:text];
    text = [text stringByAppendingString:span_enTag];
    
    return text;
}



@end
