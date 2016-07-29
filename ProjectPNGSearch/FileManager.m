//
//  FileManager.m
//  ProjectPNGSearch
//
//  Created by runlin on 16/7/28.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import "FileManager.h"
@interface FileManager ()
@property (nonatomic, weak) NSFileManager *fileManager;
@end

@implementation FileManager


+ (FileManager *) sharedManager
{
    static FileManager *fileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileManager = [[self alloc] init];
    });
    return fileManager;
}
- (id)init
{
    self = [super init];
    if (self) {
        _fileManager = [NSFileManager defaultManager];
    }
    return self;
}


-(NSMutableArray *)findProjectPNG:(NSURL *)projectPath{
    
    NSURL *url = projectPath;
    
    NSError *error = nil;
    NSMutableArray *illegalList = [[NSMutableArray alloc] init];
    
    NSArray *contents = [_fileManager contentsOfDirectoryAtURL:url
                                   includingPropertiesForKeys:@[]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:&error];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension == 'png'"];
    for (NSURL *fileURL in [contents filteredArrayUsingPredicate:predicate]) {
        // 在目录中枚举 .png 文件
        
        //        NSLog(@"%@",fileURL);
        
        NSString *file = [NSString stringWithFormat:@"%@",fileURL];
        
        
        //判断文件是否存在 @ 符号
        if (![file containsString:@"@"]) {
            
            NSArray *arrSeparation = [file componentsSeparatedByString:@"/"];
            NSString *pngName = [[[arrSeparation lastObject] componentsSeparatedByString:@"."] firstObject];
            
            NSString *filePath2x = ({
                NSString *urlStr = [NSString stringWithFormat:@"%@",url];
                NSString *fileName2x = [NSString stringWithFormat:@"%@%@",pngName,@"@2x.png"];
                [urlStr stringByAppendingPathComponent:fileName2x];
            });
            
            
            
            NSString *filePath3x = ({
                NSString *urlStr = [NSString stringWithFormat:@"%@",url];
                NSString *fileName3x = [NSString stringWithFormat:@"%@%@",pngName,@"@3x.png"];
                [urlStr stringByAppendingPathComponent:fileName3x];
            });
            
            
            //判断文件是否存在
            BOOL result = [_fileManager fileExistsAtPath:filePath2x] && [_fileManager fileExistsAtPath:filePath3x];
            
            if (!result) {
                NSLog(@"%@的文件不合法",file);
                [illegalList addObject:file];
            }
        }
        //判断文件是否存在 @2x 符号
        
        //判断文件是否存在 @3x 符号
    }
    
    
    return illegalList;
}

@end
