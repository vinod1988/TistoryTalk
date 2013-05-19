//
//  CategoryApi.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 19..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingKeys.h"
#import "StandardUserSettings.h"
#import "JSONKit.h"
#import "CategoryInfo.h"
#import "ApiUtils.h"

@interface CategoryApi : NSObject
{
    NSString* apiUrl;
}

-(NSMutableArray*)getAllCategory;

@end
