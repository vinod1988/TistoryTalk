//
//  TagManager.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 1. 24..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

@interface TagManager : NSObject
{
    NSString *mode; //preview, posting
}

@property(nonatomic, retain) NSString * mode;


+(TagManager *)singleTon_GetInstance;
+(bool)isSigleton;
+(void)destructor;

-(NSString*) convertHtmlDocument:(NSMutableArray*) jsonData;



@end
