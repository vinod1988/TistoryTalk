//
//  NSPostingUpload.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 19..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPostingUpload : NSObject
{ 
}


@property(nonatomic, readwrite) NSString *postingHtmlContent;
@property(nonatomic, readwrite) NSString *tags;
@property(nonatomic, readwrite) NSString *categoryID;
@property(nonatomic, readwrite) NSString *title;

@end
