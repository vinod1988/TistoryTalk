//
//  WriteApi.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 19..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SettingKeys.h"
#import "StandardUserSettings.h"
#import "JSONKit.h"
#import "ApiUtils.h"
#import "HTTPRequest.h"

@interface WriteApi : NSObject 

-(void)post:(NSString*)title tags:(NSString*)tag categoryID:(NSString*)categoryID content:(NSString*)content;

-(void)didReceiveFinished:(id)sender;

@end
