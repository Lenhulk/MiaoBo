//
//  LTHomeADCell.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/1.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTHomeADCell.h"
#import "LTTopADs.h"

@implementation LTHomeADCell

- (void)setTopADs:(NSArray *)topADs{
    
    _topADs = topADs;
    
    //轮播图片数组
    NSMutableArray *imgUrlArr = [NSMutableArray array];
    
    //描述数组
//    NSMutableArray *descArr = [NSMutableArray array];
    
    for (LTTopADs *adItem in topADs) {
        [imgUrlArr addObject:adItem.imageUrl];
//        [descArr addObject:adItem.title];
    }

    //创建轮播器
    XRCarouselView *carouselView = [[XRCarouselView alloc] init];
    carouselView.imageArray = imgUrlArr;
    carouselView.delegate = self;
    carouselView.frame = self.contentView.bounds;
    [self.contentView addSubview:carouselView];
}

#pragma mark - DELEGATE
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{
    //点击图片时传入模型数据
    if (self.adImageClickBlock) {
        self.adImageClickBlock(self.topADs[index]);
    }
}

@end
