//
//  TistoryAuth.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 3..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TistoryAuth : NSObject
{
    
}

+(void)setToken:(NSString*)token;
+(NSString*)getToken;
+(bool)exist;



@end
