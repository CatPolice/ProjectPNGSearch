//
//  FileManager.h
//  ProjectPNGSearch
//
//  Created by runlin on 16/7/28.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (FileManager *)sharedManager;


//
-(NSMutableArray *)findProjectPNGAll:(NSString *)projectPath;

-(NSMutableArray *)findProjectPNG2x:(NSString *)projectPath;

@end
