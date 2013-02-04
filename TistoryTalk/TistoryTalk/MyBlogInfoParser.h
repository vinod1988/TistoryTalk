//
//  MyBlogInfoParser.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 2. 1..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyBlogInfoParser : NSObject
<NSXMLParserDelegate>
{
    NSString *parsedMyBlogUrl;
    NSString *parsedMyBlogUrl2;
    
    NSString *tempParsedMyBlogUrl;
    NSString *tempParsedMyBlogUrl2;
     
    NSString *currentTagName;
    
}

-(void) requestMyBlogInfo:(NSString*)accessToken;

@end
