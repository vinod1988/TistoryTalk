//
//  NSPosting.h
//

//
//  Created by an seonghyun on 13. 5. 17..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>

//하나의 포스팅(글)에 대한 데이터 클래스
//저장하고, 읽어오는 단위

@interface NSPosting : NSObject
<NSCoding>
{
    NSMutableArray *data; //포스팅내 일련의 데이터
    NSDate *createDate; //처음 만든 날짜.
    NSString *tempTitle; //임시 제목
    
    /* 제목, 카테고리, 태그는 올릴때 지정할수 있게 한다.*/
    /* 로컬 저장시에는 저장할 필요가 없다. */ 
}
-(NSMutableArray*)getPostingData;
-(void)addData:(NSObject*)obj;
-(NSObject*)getDataAtIndex:(int)index;
-(int)getDataCount;
-(void)removeObjectAtIndex:(int)index;
-(void)removeAllObjects;
-(void)insertObject:(NSObject*)obj atIndex:(NSUInteger)index;
-(void)setTempTitle:(NSString*)title;
-(NSString*)getRandomString;

-(NSString*)getTempTitle;
-(NSDate*)getCreateDate;

@end
