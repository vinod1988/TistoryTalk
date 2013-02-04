

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
    [singleTon release];
    singleTon = nil;
}

- (NSString *) getFilePath:(NSString*) fileName
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString * document_dic = [paths objectAtIndex:0];
    
	NSString * path = [document_dic stringByAppendingFormat:@"/%@.plist", fileName];
  //  NSLog(@"%@", path);
    
	return path;
}


-(void)saveDataToFile:(NSMutableArray*) dataCollection filename:(NSString*)fileName
{
    
 	NSString *savedDestPath = [self getFilePath:fileName];
 
	[dataCollection writeToFile:savedDestPath  atomically:YES];
}

-(NSMutableArray*) getDataFromFile:(NSString*)fileName
{
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:[self getFilePath:fileName]];
   
    return [data autorelease];
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
