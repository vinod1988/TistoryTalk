//
//  NSColor.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 27..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSColor : NSObject

+ (NSString*) colorToHexString:(UIColor*)_color;
+ (UIColor *) colorFromHexString:(NSString *)hexString;

@end
