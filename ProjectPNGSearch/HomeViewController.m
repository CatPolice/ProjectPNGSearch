//
//  HomeViewController.m
//  ProjectPNGSearch
//
//  Created by runlin on 16/7/28.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import "HomeViewController.h"
#import "FileManager.h"
#import "DJProgressHUD.h"

@interface HomeViewController ()<NSTableViewDataSource,NSTableViewDelegate>
{
    NSArray *_dataSource;
    __weak IBOutlet NSTextField *_inputPath;
    __weak IBOutlet NSTextField *_errorLable;
    
    __weak IBOutlet NSButton *checkBoxButtonOutlet;
}


@property (weak) IBOutlet NSTableView *pngTableview;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)awakeFromNib{
    [self.pngTableview setTarget:self];
    [self.pngTableview setDoubleAction:NSSelectorFromString(@"tableviewDoubleClick:")];
}


/**
 *  查找按钮点击
 */
- (IBAction)searchButtonAction:(id)sender {
    NSString *inputText = [_inputPath stringValue];
    if (inputText.length) {
        [DJProgressHUD showStatus:@"查找中..." FromView:self.view];
        
        NSArray *temp;
        
        if (checkBoxButtonOutlet.state) {
            temp = [NSArray arrayWithArray:[[FileManager sharedManager] findProjectPNGAll:inputText]];

        }else{
            temp = [NSArray arrayWithArray:[[FileManager sharedManager] findProjectPNG2x:inputText]];
        }
        
        NSSet *set = [[NSSet alloc] initWithArray:temp];
        _dataSource = [NSArray arrayWithArray:[set allObjects]];
        
        
        if (_dataSource.count) {
            [self.pngTableview reloadData];
            
            _errorLable.stringValue = ({
                NSString *str1 = @"共查找到";
                NSString *strNum = [NSString stringWithFormat:@"%zd",_dataSource.count];
                NSString *str2 = @"张不合法的图片";
                [NSString stringWithFormat:@"%@%@%@",str1,strNum,str2];
            });
        }
        
        [DJProgressHUD dismiss];
    }
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
}

//是否允许编辑当前所在行的数据
- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    return NO;
}


- (void)tableviewDoubleClick:(id)sender
{
    NSInteger index = [self.pngTableview clickedRow];
    
    NSString *inputText = [_inputPath stringValue];
    NSString *fileName = [_dataSource objectAtIndex:index];
    
    NSString *str = [inputText stringByAppendingPathComponent:fileName];
    NSString *newPath = [str stringByDeletingLastPathComponent];
    
    [[NSWorkspace sharedWorkspace] openFile:newPath];
}


@end
