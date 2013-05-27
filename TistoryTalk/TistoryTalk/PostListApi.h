//
//  PostList.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 27..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingKeys.h"
#import "StandardUserSettings.h"
#import "JSONKit.h"
#import "ApiUtils.h"
#import "PostListInfo.h"

@interface PostListApi : NSObject
{
    NSString* apiUrl;
    
}

-(NSMutableArray*)getDefaultPostList;
-(NSMutableArray*)getPostList:(int)page count:(int)countPerPage categoryId:(NSString*)categoryId sort:(int)sort;
@end
