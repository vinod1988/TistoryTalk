

#import <Foundation/Foundation.h>

#import "NSPosting.h"


@interface DataManager : NSObject
{
    
    
}

+(DataManager *)singleTon_GetInstance;
+(bool)isSigleton;
+(void)destructor;

- (NSString *) getFilePath:(NSString*) filename;


-(void)savePostingToFile:(NSPosting*) dataCollection filename:(NSString*)fileName;
-(void)savePostingIndexToFile:(NSMutableArray*) dataCollection filename:(NSString*)fileName;

-(NSMutableArray*)loadPostingIndexFromFile:(NSString*)filePath;
-(NSPosting*)loadPostingFromFile:(NSString*)filePath;
-(void)deleteFile:(NSString*)fileName;



- (NSMutableArray*) getDataFromFile:(NSString*)fileName;
- (NSArray*) getDescendingFileList;
-(NSString*) getDocumentPath;

@end
