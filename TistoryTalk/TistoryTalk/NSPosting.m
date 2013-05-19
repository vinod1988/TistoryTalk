//
//  NSPosting.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 17..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "NSPosting.h"

@implementation NSPosting


//생성자
-(id)init
{
    if ( self = [super init] )
    {
        data = [[NSMutableArray alloc]init];
        createDate = [NSDate date];
        tempTitle = @"";
    } 
    return self;
}

-(NSMutableArray*)getPostingData
{
    return data;
}

-(void)setTempTitle:(NSString*)title
{
    tempTitle = title; 
}

-(NSString*)getTempTitle
{
    return tempTitle;
}


-(NSDate*)getCreateDate
{
    return createDate;
}

-(NSString*)getRandomString
{
    int r1 = arc4random() % [data count];
    int r2 = arc4random() % [data count];
    int r3 = arc4random() % [data count];
    
    NSString *rStr1 = (NSString*)[data objectAtIndex:r1];
    NSString *rStr2 = (NSString*)[data objectAtIndex:r2];
    NSString *rStr3 = (NSString*)[data objectAtIndex:r3];
    
    return [NSString stringWithFormat:@"%@%@%@", rStr1, rStr2, rStr3 ];
}


-(void)insertObject:(NSObject*)obj atIndex:(NSUInteger)index
{
    [data insertObject:obj atIndex:index];
}

-(void)addData:(NSObject*)obj
{
    [data addObject:obj];
}

-(void)removeObjectAtIndex:(int)index
{
    [data removeObjectAtIndex:index];
}

-(void)removeAllObjects
{
    [data removeAllObjects];
}

-(NSObject*)getDataAtIndex:(int)index
{
    return [data objectAtIndex:index];
}

-(int)getDataCount
{
    return data.count; 
}

#pragma mark NSCoding
// 인코딩. 인코딩시 인코더가 이 메소드를 호출한다.
-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:data  forKey:@"data"];
    [aCoder encodeObject:createDate forKey:@"createDate"];
    [aCoder encodeObject:tempTitle forKey:@"tempTitle"]; 
     
    
    
}

// 디코딩. 디코딩시 디코더가 이 메소드를 호출한다.
-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        data        = [aDecoder decodeObjectForKey:@"data"];
        createDate  = [aDecoder decodeObjectForKey:@"createDate"];
        tempTitle   = [aDecoder decodeObjectForKey:@"tempTitle"];
    }
    
    return self;
}



@end
