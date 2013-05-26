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
        dataArr = [[NSMutableArray alloc]init];
        accessoryArr = [[NSMutableArray alloc]init];
        createDate = [NSDate date];
        tempTitle = @"";
    }
    return self;
}

-(NSMutableArray*)getPostingData
{//포스팅 데이터 전체를 돌려준다.
    return dataArr;
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
    int r1 = arc4random() % [dataArr count];
    int r2 = arc4random() % [dataArr count];
    int r3 = arc4random() % [dataArr count];
    
    NSString *rStr1 = (NSString*)[dataArr objectAtIndex:r1];
    NSString *rStr2 = (NSString*)[dataArr objectAtIndex:r2];
    NSString *rStr3 = (NSString*)[dataArr objectAtIndex:r3];
    
    return [NSString stringWithFormat:@"%@%@%@", rStr1, rStr2, rStr3 ];
}


-(void)insertPostingData:(NSObject*)obj atIndex:(NSUInteger)index
{//포스팅 데이터 넣기
    [dataArr insertObject:obj atIndex:index];
}

-(void)addPostingData:(NSObject*)obj
{//포스팅 데이터 추가
    [dataArr addObject:obj];
}

-(void)removePostingAtIndex:(int)index
{//포스팅 데이터 지우기
    [dataArr removeObjectAtIndex:index];
}

-(void)removeAllPostings
{//포스팅 데이터 전체 지우기
    [dataArr removeAllObjects];
}

-(NSObject*)getPostingDataAtIndex:(int)index
{//특정 인덱스의 포스팅 데이터 가져오기
    return [dataArr objectAtIndex:index];
}

-(int)getPostingDataCount
{//포스팅 데이터 수 리턴
    return dataArr.count;
}



-(void)addAccessory:(NSAccessory*)accessory
{
    [accessoryArr addObject:accessory];
}

-(void)removeAccessoryAtIndex:(int)index
{
    [accessoryArr removeObjectAtIndex:index];
}

-(void)removeAllAccessroy
{
    [accessoryArr removeAllObjects];
}
-(int)getAccessoryCount
{
    return accessoryArr.count;
}

-(NSMutableArray*)getAccessory
{
    return accessoryArr;
}

-(NSAccessory*)getAccessoryAtIndex:(int)index;
{
    return [accessoryArr objectAtIndex:index];
}



#pragma mark NSCoding
// 인코딩. 인코딩시 인코더가 이 메소드를 호출한다.
-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:dataArr  forKey:@"dataArr"];
    [aCoder encodeObject:createDate forKey:@"createDate"];
    [aCoder encodeObject:tempTitle forKey:@"tempTitle"];
    [aCoder encodeObject:accessoryArr forKey:@"accessoryArr"];
    
    
}

// 디코딩. 디코딩시 디코더가 이 메소드를 호출한다.
-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        dataArr        = [aDecoder decodeObjectForKey:@"dataArr"];
        createDate  = [aDecoder decodeObjectForKey:@"createDate"];
        tempTitle   = [aDecoder decodeObjectForKey:@"tempTitle"];
        accessoryArr   = [aDecoder decodeObjectForKey:@"accessoryArr"];
    }
    
    return self;
}



@end
