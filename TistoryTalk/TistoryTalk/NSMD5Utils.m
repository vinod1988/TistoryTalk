//
//  NSMD5Utils.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 17..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "NSMD5Utils.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSMD5Utils

+(NSString*) md5:(NSString*)srcStr
{
    const char *cStr = [srcStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}

@end
