//
//  NSDateUtils.m
//  SavingAlarmApp
//
//  Created by an seonghyun on 13. 4. 18..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "NSDateUtils.h"

@implementation NSDateUtils
+(NSString*)getWeek:(NSDate*)date
{
    int year = [NSDateUtils getYear:date];
    int month = [NSDateUtils getMonth:date];
    int day = [NSDateUtils getDay:date];
    
    int week = [NSDateUtils getDayOfWeek:year month:month day:day];
    
    NSString* weekStr = @"월요일";
    
    switch (week) {
        case 0:
            weekStr = @"일요일";
            break;
        
        case 1:
            weekStr = @"월요일";
            break;
            
        case 2:
            weekStr = @"화요일";
            break;
            
        case 3:
            weekStr = @"수요일";
            break;
            
        case 4:
            weekStr = @"목요일";
            break;
            
        case 5:
            weekStr = @"금요일";
            break;
            
        case 6:
            weekStr = @"토요일";
            break;
        default:
            break;
    }
    
    return weekStr;
}
 
+(int)getDayOfWeek:(int)year month:(int)month day:(int)day
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:day];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:dateComponents];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    
    return [weekdayComponents weekday] - 1;
}


+(NSString*)getDateStr:(NSDate*) date
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy/MM/dd"]; 
    return [formatter stringFromDate:date];
    
}

+(NSString*)getShortDateStr:(NSDate*) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM.dd"];
    return [formatter stringFromDate:date];
    
}


+(NSString*)getShortestDateStr:(NSDate*) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"dd"];
    return [formatter stringFromDate:date];
    
}

+(NSDate*) getDateByFormat:(NSString*) dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    NSDate *date= [[NSDate alloc] init];
    date = [formatter dateFromString:dateStr];
    return date;
}

+(int) getYear:(NSDate*) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy"];
    return [[formatter stringFromDate:date] intValue];
}

+(int) getMonth:(NSDate*) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM"];
    return [[formatter stringFromDate:date] intValue];
}

+(int) getDay:(NSDate*) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"dd"];
    return [[formatter stringFromDate:date] intValue];
}


+(int) calculateDDayFromNow:(NSDate*)from
{
    NSDate *now = [NSDate date];
    return [self calculateDDay:from to:now];
}


+(int) calculateMonthFromNow:(NSDate*)from
{
    NSDate *now = [NSDate date];
    return [self calculateMonth:from to:now];
}




+(int) calculateDDay:(NSDate*)from to:(NSDate*)to
{
    NSDateComponents *dcom = [[NSCalendar currentCalendar]components:NSDayCalendarUnit
                                                            fromDate:from
                                                              toDate:to
                                                             options:0];
    
    return [dcom day];
}


+(int) calculateMonth:(NSDate*)from to:(NSDate*)to
{
    NSDateComponents *dcom = [[NSCalendar currentCalendar]components:NSMonthCalendarUnit
                                                            fromDate:from
                                                              toDate:to
                                                             options:0];
    
    return [dcom month];
}





@end
