//
//  AppDelegate.m
//  ProjectPNGSearch
//
//  Created by runlin on 16/7/28.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()
{
    HomeViewController *_home;
}
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    _home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:[NSBundle bundleForClass:[self class]]];
    
    self.window.title = @"查找项目中所缺少的2倍3倍图";
    [self.window.contentView addSubview:_home.view];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
