

#import "DataManager.h"


@implementation DataManager


static DataManager * singleTon = nil;


+(DataManager *)singleTon_GetInstance
{
	if(singleTon == nil)
    {
        
		singleTon = [[super allocWithZone:NULL] init];
        
    }
	return singleTon;
}


+(bool)isSigleton
{
    
    bool is_allocation = false;
    
    if(singleTon ==nil)
    {
        is_allocation = false;;
    }
    else
    {
        is_allocation = true;
    }
    
    return is_allocation;
}

+(void)destructor
{
    singleTon = nil;
}

- (NSString *) getFilePath:(NSString*) fileName
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString * document_dic = [paths objectAtIndex:0];
	NSString * path = [document_dic stringByAppendingFormat:@"/%@.plist", fileName];
	return path;
}

-(void)savePostingIndexToFile:(NSMutableArray*)dataCollection filename:(NSString *)fileName
{//NSMutalbeArray[NSPostingIndex] 객체 저장을 위함 함수
    
    NSString *savedDestPath = [self getFilePath:fileName];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:dataCollection forKey:@"posting_index"];
    [archiver finishEncoding];
    
    [data writeToFile:savedDestPath atomically:YES];
}


-(void)savePostingToFile:(NSPosting*)dataCollection filename:(NSString *)fileName
{//NSPosting 객체 저장을 위한 함수
    
    NSString *savedDestPath = [self getFilePath:fileName];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:dataCollection forKey:@"posting"];
    [archiver finishEncoding];
    
    [data writeToFile:savedDestPath atomically:YES];
}


-(NSMutableArray*)loadPostingIndexFromFile:(NSString*)fileName
{//파일에서 NSMutalbeArray[NSPostingIndex] 객체 로드를 위한 함수
    
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self getFilePath:fileName] ];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSMutableArray *dataCollection = [unarchiver decodeObjectForKey:@"posting_index"];
    [unarchiver finishDecoding];
    
    return dataCollection;
}
    
-(NSPosting*)loadPostingFromFile:(NSString*)fileName
{//파일에서 NSPosting 객체 로드를 위한 함수
    
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self getFilePath:fileName] ];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSPosting *dataCollection = (NSPosting*)[unarchiver decodeObjectForKey:@"posting"];
    [unarchiver finishDecoding];
    
    return dataCollection;
}


-(void)deleteFile:(NSString*)fileName
{
    NSFileManager *nsf =[[NSFileManager alloc]init];
    [nsf removeItemAtPath:[self getFilePath:fileName]  error:nil];
}



-(NSMutableArray*) getDataFromFile:(NSString*)fileName
{
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:[self getFilePath:fileName]];
   
    return data;
}

-(NSArray*) getDescendingFileList
{
    
	NSString * documentPath =[self getDocumentPath];
    NSArray *list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentPath error:nil];
    
    
    NSArray *sortedList = [list sortedArrayUsingComparator:^(NSString *filePath1, NSString *filePath2) {
        return [filePath2 compare:filePath1]; //descending
        
    }];
    
    return sortedList;
}

-(NSString*) getDocumentPath
{
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString * documentPath = [paths objectAtIndex:0];
    
    return documentPath;
}





@end
