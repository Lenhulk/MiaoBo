//
//  LTLiveBroadcastLayout.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/3.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTLiveBroadcastLayout.h"

@implementation LTLiveBroadcastLayout

- (void)prepareLayout{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemSize = self.collectionView.bounds.size;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

@end
