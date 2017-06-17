//
//  LTMainViewController.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/11.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTMainViewController.h"
#import "LTNavViewController.h"
#import "LTHomeViewController.h"
#import "LTShowTimeViewController.h"
#import "LTProfileViewController.h"
#import "UIDevice+Extension.h"
#import "UIAlertController+LTAlert.h"
#import <AVFoundation/AVFoundation.h>

@interface LTMainViewController ()<UITabBarControllerDelegate>

@end

@implementation LTMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setup];
}

/// 初始化子控制器
- (void)setup{
    
    [self setupChildViewController:[[LTHomeViewController alloc] init] imageName:@"toolbar_home"];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self setupChildViewController:vc imageName:@"toolbar_live"];
    
    [self setupChildViewController:[[LTProfileViewController alloc] init]  imageName:@"toolbar_me"];
}

/// 创建导航控制器
- (void)setupChildViewController:(UIViewController *)vc imageName:(NSString *)imgName{
    
    LTNavViewController *nav = [[LTNavViewController alloc] initWithRootViewController:vc];
    vc.tabBarItem.image = [UIImage imageNamed:imgName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:[imgName stringByAppendingString:@"_sel"]];
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    [self addChildViewController:nav];
}

#pragma mark - TabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    //判断点击了直播按钮
    if ([tabBarController.childViewControllers indexOfObject:viewController] == tabBarController.childViewControllers.count - 2) {
        
        //判断是否是模拟器
        if ([[UIDevice deviceVersion] isEqualToString:KIsSimulator]) {
            [self presentViewController:[UIAlertController showAlert:@"请在真机上调试，模拟器无法直播"] animated:YES completion:nil];
            return NO;
        }
        
        //判断是否有摄像头
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self presentViewController:[UIAlertController showAlert:@"您的设备没有摄像头或者相关的驱动, 不能进行直播"] animated:YES completion:nil];
            return NO;
        }
        
        //获取摄像头权限
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusRestricted==status || AVAuthorizationStatusDenied==status) {
            [self presentViewController:[UIAlertController showAlert:@"app需要访问您的摄像头。\n请启用摄像头 -> 设置/隐私/摄像头"] animated:YES completion:nil];
            return NO;
        }
        
        //获取麦克风权限
        AVAudioSession *avSession = [AVAudioSession sharedInstance];
        if ([avSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [avSession requestRecordPermission:^(BOOL granted) {
                if (granted) ;
                else{
                    [self presentViewController:[UIAlertController showAlert:@"app需要访问您的麦克风。\n请启用麦克风 -> 设置/隐私/麦克风"] animated:YES completion:nil];
                }
            }];
        }
        
        //弹出控制器
        LTShowTimeViewController *showTimeVc = [UIStoryboard storyboardWithName:NSStringFromClass([LTShowTimeViewController class]) bundle:nil].instantiateInitialViewController;
        [self presentViewController:showTimeVc animated:YES completion:nil];
        
        //使Tab对应的控制器不被激活（而是弹出自定义的ShowTimeVC）
        return NO;
    }
    
    return YES;
}


@end
