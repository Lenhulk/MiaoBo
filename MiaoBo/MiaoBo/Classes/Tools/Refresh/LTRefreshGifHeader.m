//
//  LTRefreshGifHeader.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/13.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTRefreshGifHeader.h"

@implementation LTRefreshGifHeader

- (instancetype)init{
    if (self = [super init]) {
        
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.hidden = YES;
        [self setImages:@[[UIImage imageNamed:@"reflesh1_60x55_"]] forState:MJRefreshStateIdle];
        [self setImages:@[[UIImage imageNamed:@"reflesh1_60x55_"]] forState:MJRefreshStatePulling];
        [self setImages:@[[UIImage imageNamed:@"reflesh1_60x55_"], [UIImage imageNamed:@"reflesh2_60x55_"], [UIImage imageNamed:@"reflesh3_60x55_"]] forState:MJRefreshStateRefreshing];
         
    }
    return self;
}

@end
