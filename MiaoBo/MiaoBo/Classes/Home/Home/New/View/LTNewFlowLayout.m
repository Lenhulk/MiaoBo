//
//  LTNewFlowLayout.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/13.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTNewFlowLayout.h"

@implementation LTNewFlowLayout

- (void)prepareLayout{
    
    [super prepareLayout];
    
    CGFloat wh = (KScreenW - 3) / 3.0;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemSize = CGSizeMake(wh, wh);
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceVertical = YES;
}

@end
