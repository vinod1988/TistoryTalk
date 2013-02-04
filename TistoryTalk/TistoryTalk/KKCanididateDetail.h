//
//  KKCanididateDetail.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 2. 2..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKCanididateDetail : NSObject
{
    
    NSString *political_party;
    NSString *name;
    NSString *area;
    
    NSString *homepage;
    
    NSString *leave;
    NSString *business;
    NSString *absence;
    NSString *abstention;
    NSString *not_vote;
    NSString *attendance;
    NSString *opposite;
    NSString *agree;

    
    
    NSString *photo;
    
    /*
     상세 API
     url : /api/detail/KEY
     변수
     KEY = 국회의원 ID
     결과값
     name = 이름
     key = 고유ID
     photo = 사진
     political_party = 정당 이름
     email = 이메일
     homepage = 홈페이지
     commission = 상임위원회
     area = 지역구
     attendance= 출석수
     absence= 결석수
     leave= 청가수
     business= 출장수
     agree = 찬성수
     opposite = 반대수
     abstention = 기권수
     not_vote = 불참수

     */
  
    
}
@property(nonatomic, retain)  NSString *political_party;

@property(nonatomic, retain)  NSString *name;
@property(nonatomic, retain) NSString *area;
@property(nonatomic, retain)   NSString *opposite;

@property(nonatomic, retain) NSString *agree;
@property(nonatomic, retain)   NSString *leave;

@property(nonatomic, retain)NSString *homepage; 
 
@property(nonatomic, retain) NSString *business;
@property(nonatomic, retain) NSString *abstention;
@property(nonatomic, retain) NSString *not_vote;
@property(nonatomic, retain) NSString *attendance; 

@property(nonatomic, retain) NSString *photo;
@property(nonatomic, retain) NSString *absence;




@end
