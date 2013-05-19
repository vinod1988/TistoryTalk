//
//  NSPostingIndex.m
//  TistoryTalk
//
//  Created by an seonghyun on 13. 5. 17..
//  Copyright (c) 2013년 INDF. All rights reserved.
//

#import "NSPostingIndex.h"

@implementation NSPostingIndex

-(void)setFileName:(NSString*)_fileName
{
    fileName = _fileName;
}


-(void)setTempTitle:(NSString*)_tempTitle
{
    tempTitle = _tempTitle;
}


-(void)setCreateDate:(NSDate*)_createDate
{
    createDate = _createDate;
}



-(NSString*)getFileName
{
    return fileName;
}
-(NSString*)getTempTitle
{
    return tempTitle;
}
-(NSDate*)getCreateDate
{
    return createDate;
}

#pragma mark NSCoding
// 인코딩. 인코딩시 인코더가 이 메소드를 호출한다.
-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:fileName  forKey:@"fileName"];
    [aCoder encodeObject:createDate forKey:@"createDate"];
    [aCoder encodeObject:tempTitle forKey:@"tempTitle"];
    
}

// 디코딩. 디코딩시 디코더가 이 메소드를 호출한다.
-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        fileName    = [aDecoder decodeObjectForKey:@"fileName"];
        createDate  = [aDecoder decodeObjectForKey:@"createDate"];
        tempTitle   = [aDecoder decodeObjectForKey:@"tempTitle"];
    }
    
    return self;
}

@end
