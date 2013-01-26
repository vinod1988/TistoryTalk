

#import <Foundation/Foundation.h>



@interface DataManager : NSObject
{
    
    
}

+(DataManager *)singleTon_GetInstance;
+(bool)isSigleton;
+(void)destructor;

- (NSString *) getFilePath:(NSString*) filename;
- (void)saveDataToFile:(NSMutableArray*) dataCollection filename:(NSString*)fileName;
- (NSMutableArray*) getDataFromFile:(NSString*)fileName;
- (NSArray*) getDescendingFileList;
-(NSString*) getDocumentPath;

@end
