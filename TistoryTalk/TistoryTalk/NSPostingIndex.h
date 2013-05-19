//
//  NSPostingIndex.h
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 17..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPostingIndex : NSObject
<NSCoding>
{
    NSString *fileName;
    NSString *tempTitle;
    NSDate   *createDate;
    
}
-(void)setFileName:(NSString*)_fileName;
-(void)setTempTitle:(NSString*)_tempTitle;
-(void)setCreateDate:(NSDate*)_createDate;


-(NSString*)getFileName;
-(NSString*)getTempTitle;
-(NSDate*)getCreateDate;


@end
