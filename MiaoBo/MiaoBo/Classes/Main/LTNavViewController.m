//
//  LTNavViewController.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/11.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTNavViewController.h"

@interface LTNavViewController ()

@end

@implementation LTNavViewController

+ (void)initialize{
    //导航栏样式
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],
                                     NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

#pragma mark - 控制器跳转方法

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //有子控制器的情况下
    if (self.childViewControllers.count) {
        
        //隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        //自定义返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:@" 喵播" forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"back_9x16"] forState:UIControlStateNormal];
        [backBtn sizeToFit];
        [backBtn addTarget:self action:@selector(jumpBack) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    
    [super pushViewController:viewController animated:YES];
}

/// 返回按钮的回跳 断两种情况: push 和 present
- (void)jumpBack{
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self popViewControllerAnimated:YES];
    }
}

@end
