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
        accessory = [[NSMutableArray alloc]init];
        createDate = [NSDate date];
        tempTitle = @"";
    }
    return self;
}

-(NSMutableArray*)getPostingData
{//포스팅 데이터 전체를 돌려준다. 
    return data;
}

-(void)setTempTitle:(NSString*)title
{//임시제목 세팅 
    tempTitle = title; 
}

-(NSString*)getTempTitle
{//임시제목 반환 
    return tempTitle;
}


-(NSDate*)getCreateDate
{//생성일 반환
    return createDate;
}

-(NSString*)getRandomString
{//랜덤 문자열 추출
    int r1 = arc4random() % [data count];
    int r2 = arc4random() % [data count];
    int r3 = arc4random() % [data count];
    
    NSString *rStr1 = (NSString*)[data objectAtIndex:r1];
    NSString *rStr2 = (NSString*)[data objectAtIndex:r2];
    NSString *rStr3 = (NSString*)[data objectAtIndex:r3];
    
    return [NSString stringWithFormat:@"%@%@%@", rStr1, rStr2, rStr3 ];
}


-(void)insertObject:(NSObject*)obj atIndex:(NSUInteger)index
{//포스팅 데이터 넣기
    [data insertObject:obj atIndex:index];
}

-(void)addData:(NSObject*)obj
{//포스팅 데이터 추가
    [data addObject:obj];
}

-(void)removeObjectAtIndex:(int)index
{//포스팅 데이터 지우기
    [data removeObjectAtIndex:index];
}

-(void)removeAllObjects
{//포스팅 데이터 전체 지우기
    [data removeAllObjects];
}

-(NSObject*)getDataAtIndex:(int)index
{//특정 인덱스의 포스팅 데이터 가져오기
    return [data objectAtIndex:index];
}

-(int)getDataCount
{//포스팅 데이터 수 리턴
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
