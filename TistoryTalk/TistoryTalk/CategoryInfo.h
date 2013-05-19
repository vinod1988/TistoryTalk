//
//  CategoryInfo.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 19..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryInfo : NSObject
{

    
}

@property(nonatomic, readwrite) NSString* categoryId;//	카테고리 ID
@property(nonatomic, readwrite) NSString* name;	//카테고리 명
@property(nonatomic, readwrite) NSString* parent;	//부모 카테고리	하위 카테고리일때 표시
@property(nonatomic, readwrite) NSString* label;	//부모 카테고리명이 포함된 카테고리명	'부모카테고리/자식카테고리' 형태로 표시
@property(nonatomic, readwrite) int entries;	//카테고리내 글 수	비공개글 제외
@property(nonatomic, readwrite) int entriesInLogin;	//카테고리내 글 수	비공개글을 포함한 수 (주인 권한)

@end
