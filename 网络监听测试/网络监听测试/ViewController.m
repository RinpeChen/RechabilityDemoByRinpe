//
//  ViewController.m
//  网络监听测试
//
//  Created by RinpeChen on 15/12/15.
//  Copyright © 2015年 miaoqukeji. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange:) name:@"networkChangeNotification" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)networkChange:(NSNotification *)notification
{
    NSString *status = notification.userInfo[@"networkStatusKey"];
    
    if (status.boolValue) {         // 断网切换为正常状态
        NSLog(@"断网切换为正常状态");
    } else {                        // 正常切换为断网状态
        NSLog(@"正常切换为断网状态");
    }
}

@end
