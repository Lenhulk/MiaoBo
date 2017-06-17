//
//  AppDelegate.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/11.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "AppDelegate.h"
#import "LTMainViewController.h"
#import "Reachability.h"
//#import "UIAlertController+LTAlert.h"
#import "UIViewController+LTHUD.h"

@interface AppDelegate ()
{
    Reachability *_reacha;      //获取网络状态的对象
    NetworkStatus _preNetSta;  //上一个网络状态
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //给window设置根控制器
    self.window = [[UIWindow alloc] initWithFrame:KScreenBounds];
    self.window.rootViewController = [[LTMainViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    //网络状态监听
    [self checkNetworkStates];
    
    return YES;
}

#pragma mark - 网络状态监听

- (void)checkNetworkStates{
    
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    //检测指定服务器是否可达
    _reacha = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    //开始监听，会启动一个run loop
    [_reacha startNotifier];
    
    //检测默认路由是否可达
    _reacha = [Reachability reachabilityForInternetConnection];
    [_reacha startNotifier];
    
    //    NotReachable = 0,
    //    ReachableViaWWAN = 1
    //    ReachableViaWiFi = 2,
    NetworkStatus status = [_reacha currentReachabilityStatus];
    LTLog(@"网络状态码------>%ld", status);
    
}

///当网络状态发生变化
- (void)reachabilityChanged:(NSNotification *)notification{
    
    Reachability *reacha = [notification object];
    if ([reacha isKindOfClass:[Reachability class]]) {
        
        NetworkStatus curStatus = [reacha currentReachabilityStatus];
        if (curStatus == _preNetSta) {
            return;
        }
        
        _preNetSta = curStatus;
        NSString *tips;
        switch (curStatus) {
            case NotReachable:
                tips = @"当前无网络, 请检查您的网络状态!";
                break;
                
            case ReachableViaWiFi:
                tips = @"当前是WiFi网络，请尽情享用~";
                break;
                
            case ReachableViaWWAN:
                tips = @"切换到了3G/4G网络，土豪请无视..";
                break;
        }
        
        if (tips.length) {
            //获取到屏幕上当前控制器
            UIViewController *curVc = [UIApplication sharedApplication].keyWindow.rootViewController;
//            [curVc presentViewController:[UIAlertController showAlert:tips] animated:YES completion:nil];
            [curVc showHint:tips];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
