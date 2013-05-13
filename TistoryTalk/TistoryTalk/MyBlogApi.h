//
//  MyBlogApi.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 13..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingKeys.h"
#import "StandardUserSettings.h"
#import "JSONKit.h"
#import "MyBlogInfo.h"

@interface MyBlogApi : NSObject
{
    NSString* apiUrl;
    
}

-(NSMutableArray*)getMyAllBlog;
-(MyBlogInfo*)getMyBasicBlog;
-(NSString*)getMyBasicBlogUrl;




@end
