//
//  TistoryHtmlTagManager.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 18..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TistoryHtmlTagManager : NSObject


+(TistoryHtmlTagManager *)singleTon_GetInstance;
+(bool)isSigleton; 

-(NSString*) convertHtmlDocument:(NSMutableArray*) jsonData;

@end
