//
//  HomeViewController.m
//  ProjectPNGSearch
//
//  Created by runlin on 16/7/28.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import "HomeViewController.h"
#import "FileManager.h"

@interface HomeViewController ()<NSTableViewDataSource,NSTableViewDelegate>
{
    NSArray *_dataSource;
}


@property (weak) IBOutlet NSTableView *pngTableview;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    _dataSource = [[FileManager sharedManager] findProjectPNG:[NSURL URLWithString:@"/Users/runlin/Desktop/testFile"]];
    
}

//返回表格的行数
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return [_dataSource count];
}

//用了下面那个函数来显示数据就用不上这个，但是协议必须要实现，所以这里返回nil
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return nil;
}

//显示数据
- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *data = [_dataSource objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    
    if ([identifier isEqualToString:@"name"]) {
        NSTextFieldCell *textCell = cell;
        [textCell setTitle:data];
    }
//    else if ([identifier isEqualToString:@"id"])
//    {
//        NSTextFieldCell *textCell = cell;
//        [textCell setTitle:data];
//    }
}




@end
