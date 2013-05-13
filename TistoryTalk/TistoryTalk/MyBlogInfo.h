//
//  MyBlogInfo.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 13..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <Foundation/Foundation.h>

///내 블로그 정보 클래스 - 
@interface MyBlogInfo : NSObject
{


}
 
@property(nonatomic, readwrite) NSString *url; //기본 url
@property(nonatomic, readwrite) NSString *secondaryUrl; //2차 url
@property(nonatomic, readwrite) NSString *nickName; //닉네임
@property(nonatomic, readwrite) NSString *description; //설명
@property(nonatomic, readwrite) Boolean   basicBlog; //default	대표 블로그 여부
@property(nonatomic, readwrite) NSString *blogIconUrl; //블로그 아이콘 URL
@property(nonatomic, readwrite) NSString *faviconUrl; //파비콘 URL
@property(nonatomic, readwrite) NSString *profileThumbnailImageUrl; //프로필 썸네일 이미지 URL
@property(nonatomic, readwrite) NSString *profileImageUrl;//프로필 이미지 URL

@property(nonatomic, readwrite) int pos;//글 수
@property(nonatomic, readwrite) int comment;//댓글 수
@property(nonatomic, readwrite) int trackback;//트랙백 수
@property(nonatomic, readwrite) int guestbook;//방명록 수
@property(nonatomic, readwrite) int invitation;//초대 수

@end
