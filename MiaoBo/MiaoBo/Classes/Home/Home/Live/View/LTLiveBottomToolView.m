//
//  LTLiveBottomToolView.m
//  MiaoBo
//
//  Created by 零號叔叔 on 2017/4/9.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTLiveBottomToolView.h"
#import "UIView+LTExtension.h"

@implementation LTLiveBottomToolView

- (NSArray *)tools{
    return @[@"talk_public_36x36_",
             @"talk_private_36x36_",
             @"talk_sendgift_36x36_",
             @"talk_taskCanRecived_36x36_",
             @"talk_rank_36x36_",
             @"talk_share_36x36_",
             @"talk_close_36x36_"];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setupTools];
    }
    return self;
}

- (void)setupTools{
    
    NSInteger toolNum = self.tools.count;
    CGFloat wh = 36;
    CGFloat lrMargin = 10;
    CGFloat midMargin = 50;
    CGFloat margin = (KScreenW - lrMargin * 2 - toolNum * wh - midMargin) / (toolNum - 1);
    CGFloat x = 0;
    CGFloat y = (self.height - wh) * 0.5;
    
    for (NSInteger i = 0; i < toolNum; i++) {
        x = lrMargin + i * (wh + margin);
        if (i > 1) { x += midMargin; }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(x, y, wh, wh);
        [btn setImage:[UIImage imageNamed:self.tools[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)toolClick:(UIButton *)sender{
    
    if (self.clickToolBlock) {
        LTLog(@"%ld", sender.tag);
        self.clickToolBlock(sender.tag);
    }
}

@end
