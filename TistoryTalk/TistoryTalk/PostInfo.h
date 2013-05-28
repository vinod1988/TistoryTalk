//
//  PostInfo.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 29..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostInfo : NSObject
{
    
}
@property(nonatomic, readwrite) NSString*postId;//	글 ID
@property(nonatomic, readwrite) NSString*title;//	글 제목
@property(nonatomic, readwrite) NSString*content;//	글 내용
@property(nonatomic, readwrite) NSString*categoryId;//	카테고리 아이디
@property(nonatomic, readwrite) NSString*postUrl;//	글 Full url
@property(nonatomic, readwrite) int visibility;//	글의 권한	0: 비공개, 1: 보호, 2: 공개, 3: 발행
@property(nonatomic, readwrite) int acceptComment;//	댓글허용여부	0:거부, 1:허용
@property(nonatomic, readwrite) int acceptTrackback;//	트랙백 허용 여부	0:거부, 1:허용
@property(nonatomic, readwrite) int comments;//	댓글 수
@property(nonatomic, readwrite) int trackbacks;//	트랙백 수
@property(nonatomic, readwrite) NSDate* date;//	글 등록 일

@end
