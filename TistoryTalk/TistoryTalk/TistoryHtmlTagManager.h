//
//  TistoryHtmlTagManager.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 18..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFontAccessory.h"
#import "NSColor.h"

@interface TistoryHtmlTagManager : NSObject


+(TistoryHtmlTagManager *)singleTon_GetInstance;
+(bool)isSigleton; 

-(NSString*) convertHtmlDocument:(NSMutableArray*)postingData accessory:(NSMutableArray*)postingAccessory;

@end
