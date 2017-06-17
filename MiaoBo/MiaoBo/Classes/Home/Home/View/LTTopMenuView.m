//
//  LTTopMenuView.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/12.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTTopMenuView.h"
#import <Masonry.h>

@interface LTTopMenuView ()
@property (nonatomic, weak) UIView *underLine;
@property (nonatomic, strong) UIButton *selBtn;
@property (nonatomic, weak) UIButton *hotBtn;
@end

@implementation LTTopMenuView

#pragma mark - VIEW

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setup];
    };
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - SETUP

/// 懒加载下划线
- (UIView *)underLine{
    if(!_underLine){
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(15, self.height - 4, Home_Seleted_Item_W + Home_Seleted_Item_M, 2)];
        underLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:underLine];
        _underLine = underLine;
    }
    return _underLine;
}

- (void)setup{
    
    /// 加载三个按钮
    UIButton *hotBtn = [self createButton:@"最热" :HomeTypeHot];
    UIButton *newBtn = [self createButton:@"最新" :HomeTypeNew];
    UIButton *careBtn = [self createButton:@"关注" :HomeTypeCare];
    _hotBtn = hotBtn;   //用于通知监听
    [hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(@(Home_Seleted_Item_M * 2));
        make.width.equalTo(@(Home_Seleted_Item_W));
    }];
    [newBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@(Home_Seleted_Item_W));
    }];
    [careBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(@(-Home_Seleted_Item_M * 2));
        make.width.equalTo(@(Home_Seleted_Item_W));
    }];
    //强制更新一次
    [self layoutIfNeeded];
    //默认选中
    [self clickButton:hotBtn];
    //监听点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToHot) name:kNotifyToseeBigWorld object:nil];
}

- (UIButton *)createButton:(NSString *)title :(HomeType)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTag:tag];
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

#pragma mark - SCROLL

- (void)scrollToHot{
    [self clickButton:_hotBtn];
}

- (void)clickButton:(UIButton *)sender{
    //选中按钮
    self.selBtn.selected = NO;
    sender.selected = YES;
    self.selBtn = sender;
    
    //传递block给控制器
    if(self.selectedBlock){
        self.selectedBlock(sender.tag);
    }
}

//接收block传递的值
- (void)setSelectedType:(HomeType)selectedType{
    _selectedType = selectedType;
    self.selBtn.selected = NO;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] && selectedType == view.tag) {
            self.selBtn = (UIButton *)view;
            ((UIButton *)view).selected = YES;
        }
    }
}

@end
