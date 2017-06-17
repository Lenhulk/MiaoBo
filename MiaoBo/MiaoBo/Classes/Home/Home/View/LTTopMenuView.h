//
//  LTTopMenuView.h
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/12.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//  首页顶部的自定义菜单

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HomeType) {
    HomeTypeHot,
    HomeTypeNew,
    HomeTypeCare
};

@interface LTTopMenuView : UIView

/** 选中type的block回调 */
@property (nonatomic, copy) void (^selectedBlock)(HomeType type);
/** 下划线 */
@property(nonatomic, readonly, weak) UIView *underLine;
/** 通过滚动时传入type 修改选中按钮 */
@property (nonatomic, assign) HomeType selectedType;

@end
