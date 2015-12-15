//
//  AppDelegate.m
//  网络监听测试
//
//  Created by RinpeChen on 15/12/15.
//  Copyright © 2015年 miaoqukeji. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"

@interface AppDelegate ()

@property (nonatomic, strong) Reachability *reachability;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 监听网络状态的改变
    [self networkChange];
    
    return YES;
}

// 监听网络变化
- (void)networkChange
{
    // 开启网络状况的监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    // 监听的链接
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    // 开始监听, 会启动一个Runloop
    [self.reachability startNotifier];
}

// 网络链接改变时会调用的方法
- (void)reachabilityChanged:(NSNotification *)note
{
    // 通过通知对象获取被监听的Reachability对象
    Reachability *currReach = [note object];
    NSAssert([currReach isKindOfClass:[Reachability class]], @"非Reachability类");
    
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    
    //如果没有连接到网络就提醒实况
    if(status == NotReachable) {
        NSLog(@"AppDelegate - 网络连接异常");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"networkChangeNotification" object:nil userInfo:@{@"networkStatusKey" : @(NO)}];
    } else {
        NSLog(@"AppDelegate - 网络连接正常");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"networkChangeNotification" object:nil userInfo:@{@"networkStatusKey" : @(YES)}];
    }
}

@end
