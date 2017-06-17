//
//  UIViewController+LTExtension.h
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/1.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LTExtension)

/** 加载状态的GIF动画 */
@property (nonatomic, weak) UIImageView *gifView;

/**
 *  显示GIF加载动画
 *
 *  @param images gif图片数组, 不传的话默认是自带的
 *  @param view   显示在哪个view上, 如果不传默认就是self.view
 */
- (void)showGifLoding:(NSArray *)images inView:(UIView *)view;

/**
 *  取消GIF加载动画
 */
- (void)hideGifLoding;

/**
 *  判断数组是否不为空
 *
 *  @param arr 用于判断的数组
 */
- (BOOL)isArrayNotEmpty:(NSArray *)arr;

@end
