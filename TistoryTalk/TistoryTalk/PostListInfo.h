//
//  PostListInfo.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 28..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>
//최근 게시물 목록 정보
@interface PostListInfo : NSObject
{
}

@property(nonatomic, readwrite)     NSString* id;//	포스트 ID
@property(nonatomic, readwrite)     NSString* title;	//타이틀
@property(nonatomic, readwrite)     NSString* postUrl;	//이 글의 full url
@property(nonatomic, readwrite)     int visibility;	//글보기 권한
@property(nonatomic, readwrite)     NSString* categoryId;	//카테고리 아이디
@property(nonatomic, readwrite)     int comments;	//댓글 수
@property(nonatomic, readwrite)     int trackbacks;	//트랙백 수
@property(nonatomic, readwrite)     NSDate* date;	//글 등록 일
@end
