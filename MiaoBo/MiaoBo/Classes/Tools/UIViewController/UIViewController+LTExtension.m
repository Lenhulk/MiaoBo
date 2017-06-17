//
//  UIViewController+LTExtension.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/1.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "UIViewController+LTExtension.h"
#import "UIImage+LTExtension.h"
#import <objc/runtime.h>

//v?
static const void *GifKey = &GifKey;

@implementation UIViewController (LTExtension)

#pragma mark 用runtime给UIViewController动态添加GifView属性

- (UIImageView *)gifView{
    return objc_getAssociatedObject(self, GifKey);
}

- (void)setGifView:(UIImageView *)gifView{
    objc_setAssociatedObject(self, GifKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - GifImageView Function

- (void)showGifLoding:(NSArray *)images inView:(UIView *)view{
    //创建展示动画的iamgeview
    UIImageView *gifView = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 60) * 0.5, (KScreenH - 55) * 0.5, 60, 55)];
    //如果view为空添加到当前的view
    if (!view) {
        view = self.view;
    }
    [view addSubview:gifView];
    //设置GIF动画
    NSMutableArray *gifImgs = [NSMutableArray array];
    if (!images.count) {
        for (int i=1; i<4; i++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"reflesh%d_60x55_", i]];
            [gifImgs addObject:img];
        }
    }
    gifView.animationImages = gifImgs;
    gifView.animationDuration = 0.5;
    gifView.animationRepeatCount = 0;
    //开始动画
    self.gifView = gifView;
    [gifView startAnimating];
}

- (void)hideGifLoding{
    //停止动画，移除view，设置指针为空
    [self.gifView stopAnimating];
    [self.gifView removeFromSuperview];
    self.gifView = nil;
}

#pragma mark - Array Function

- (BOOL)isArrayNotEmpty:(NSArray *)arr{
    if ([arr isKindOfClass:[NSArray class]] && arr.count) {
        return YES;
    } else {
        return NO;
    }
}

@end
