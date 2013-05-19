//
//  NSDateUtils.h
//  SavingAlarmApp
//
//  Created by an seonghyun on 13. 4. 18..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateUtils : NSObject

+(NSString*)getDateStr:(NSDate*) date;
+(NSString*)getShortDateStr:(NSDate*) date;
+(NSString*)getShortestDateStr:(NSDate*) date;

+(NSDate*) getDateByFormat:(NSString*) dateStr;

+(int) calculateDDayFromNow:(NSDate*)from;
+(int) calculateMonthFromNow:(NSDate*)from;


+(int) calculateDDay:(NSDate*)from to:(NSDate*)to;
+(int) calculateMonth:(NSDate*)from to:(NSDate*)to;


+(NSString*)getWeek:(NSDate*)date;
+(int)getDayOfWeek:(int)year month:(int)month day:(int)day;
+(int) getYear:(NSDate*) date;
+(int) getMonth:(NSDate*) date;
+(int) getDay:(NSDate*) date;

@end
