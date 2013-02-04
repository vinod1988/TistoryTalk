//
//  CategoryParser.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 2. 1..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryParser : NSObject
<NSXMLParserDelegate>
{
      NSString *currentTagName;
    NSMutableArray *categoryId;
    NSMutableArray *categoryName; 
    
    
}

-(NSMutableDictionary*) requestCategory;
-(id)init;
@end
