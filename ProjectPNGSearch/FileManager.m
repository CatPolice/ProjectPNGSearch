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


-(NSMutableArray *)findProjectPNGAll:(NSString *)projectPath{
    
    NSURL *url = [NSURL URLWithString:[projectPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSError *error = nil;
    NSMutableArray *illegalList = [[NSMutableArray alloc] init];
    
//    NSArray *contents = [_fileManager contentsOfDirectoryAtURL:url
//                                   includingPropertiesForKeys:@[]
//                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
//                                                        error:&error];
    
    NSArray *contents = [_fileManager subpathsOfDirectoryAtPath:projectPath error:&error];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension == 'png'"];
    for (NSString *file in [contents filteredArrayUsingPredicate:predicate]) {
        // 在目录中枚举 .png 文件
        
        //判断文件中是否包含.png的文件
        if ([file containsString:@".png"] && ![file containsString:@"@2x.png"] && ![file containsString:@"@3x.png"]) {
            NSArray *arrSeparation = [file componentsSeparatedByString:@".png"];
            
            NSString *pngName = [arrSeparation firstObject];
            
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
                [illegalList addObject:[file stringByRemovingPercentEncoding]];
            }
        }else if ([file containsString:@"@2x.png"] || [file containsString:@"@3x.png"]){
            NSString *filePath2x;
            NSString *filePath3x;
            
            //如果2x的话，
            if ([file containsString:@"@2x.png"]) {
                NSArray *arrSeparation = [file componentsSeparatedByString:@"@2x.png"];
                NSString *pngName = [arrSeparation firstObject];
                
                filePath2x = ({
                    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
                    NSString *fileName2x = [NSString stringWithFormat:@"%@%@",pngName,@"@2x.png"];
                    [urlStr stringByAppendingPathComponent:fileName2x];
                });
                
                
                filePath3x = ({
                    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
                    NSString *fileName3x = [NSString stringWithFormat:@"%@%@",pngName,@"@3x.png"];
                    [urlStr stringByAppendingPathComponent:fileName3x];
                });
                
                //判断文件是否存在
                BOOL result = [_fileManager fileExistsAtPath:filePath2x] && [_fileManager fileExistsAtPath:filePath3x];
                
                if (!result) {
                    NSLog(@"%@的文件不合法",file);
                    [illegalList addObject:[file stringByRemovingPercentEncoding]];
                }
                
                
            }else if ([file containsString:@"@3x.png"]){
                //如果3x的话
                NSArray *arrSeparation = [file componentsSeparatedByString:@"@3x.png"];
                NSString *pngName = [arrSeparation firstObject];
                
                filePath2x = ({
                    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
                    NSString *fileName2x = [NSString stringWithFormat:@"%@%@",pngName,@"@2x.png"];
                    [urlStr stringByAppendingPathComponent:fileName2x];
                });
                
                
                filePath3x = ({
                    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
                    NSString *fileName3x = [NSString stringWithFormat:@"%@%@",pngName,@"@3x.png"];
                    [urlStr stringByAppendingPathComponent:fileName3x];
                });
                
                
                //判断文件是否存在
                BOOL result = [_fileManager fileExistsAtPath:filePath2x] && [_fileManager fileExistsAtPath:filePath3x];
                
                if (!result) {
                    NSLog(@"%@的文件不合法",file);
                    [illegalList addObject:[file stringByRemovingPercentEncoding]];
                }
                
            }
            
            //判断文件是否存在
            BOOL result = [_fileManager fileExistsAtPath:filePath2x] && [_fileManager fileExistsAtPath:filePath3x];
            
            if (!result) {
                NSLog(@"%@的文件不合法",file);
                [illegalList addObject:[file stringByRemovingPercentEncoding]];
            }
        }
    }
    return illegalList;
}


-(NSMutableArray *)findProjectPNG2x:(NSString *)projectPath{
    NSURL *url = [NSURL URLWithString:[projectPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSError *error = nil;
    NSMutableArray *illegalList = [[NSMutableArray alloc] init];
    
    
    NSArray *contents = [_fileManager subpathsOfDirectoryAtPath:projectPath error:&error];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension == 'png'"];
    for (NSString *file in [contents filteredArrayUsingPredicate:predicate]) {
        // 在目录中枚举 .png 文件
        
        //判断文件中是否包含.png的文件
        if ([file containsString:@".png"] && ![file containsString:@"@2x.png"] && ![file containsString:@"@3x.png"]) {
            NSArray *arrSeparation = [file componentsSeparatedByString:@".png"];
            
            NSString *pngName = [arrSeparation firstObject];
            
            NSString *filePath2x = ({
                NSString *urlStr = [NSString stringWithFormat:@"%@",url];
                NSString *fileName2x = [NSString stringWithFormat:@"%@%@",pngName,@"@2x.png"];
                [urlStr stringByAppendingPathComponent:fileName2x];
            });
            
//            NSString *filePath3x = ({
//                NSString *urlStr = [NSString stringWithFormat:@"%@",url];
//                NSString *fileName3x = [NSString stringWithFormat:@"%@%@",pngName,@"@3x.png"];
//                [urlStr stringByAppendingPathComponent:fileName3x];
//            });
            
            //判断文件是否存在
            BOOL result = [_fileManager fileExistsAtPath:filePath2x];
            
            if (!result) {
                NSLog(@"%@的文件不合法",file);
                [illegalList addObject:[file stringByRemovingPercentEncoding]];
            }
        }else if ([file containsString:@"@2x.png"] || [file containsString:@"@3x.png"]){
            NSString *filePath2x;
            
            //如果2x的话，
            if ([file containsString:@"@3x.png"]) {
                NSArray *arrSeparation = [file componentsSeparatedByString:@"@3x.png"];
                NSString *pngName = [arrSeparation firstObject];
                
                filePath2x = ({
                    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
                    NSString *fileName2x = [NSString stringWithFormat:@"%@%@",pngName,@"@2x.png"];
                    [urlStr stringByAppendingPathComponent:fileName2x];
                });
                
                //判断文件是否存在
                BOOL result = [_fileManager fileExistsAtPath:filePath2x];
                
                if (!result) {
                    NSLog(@"%@的文件不合法",file);
                    [illegalList addObject:[file stringByRemovingPercentEncoding]];
                }
            }
        }
    }
    return illegalList;
}

@end
