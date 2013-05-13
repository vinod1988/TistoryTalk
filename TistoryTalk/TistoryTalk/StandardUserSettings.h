//
//  StandardUserSettings.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 13..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StandardUserSettings : NSObject
{
    
}

+(void)setValue:(NSString*)key value:(NSString*)value;
+(NSString*)getValue:(NSString*)key;
+(bool)exist:(NSString*)key;



@end
