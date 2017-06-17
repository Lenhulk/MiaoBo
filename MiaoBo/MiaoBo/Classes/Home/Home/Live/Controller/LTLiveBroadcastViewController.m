//
//  LTLiveBroadcastViewController.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/3.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTLiveBroadcastViewController.h"
#import "LTLiveBroadcastLayout.h"
#import "LTLives.h"
#import "LTLiveBroadcastCell.h"
#import "LTRefreshGifHeader.h"

@interface LTLiveBroadcastViewController ()
/** 用于信息 */
@end

@implementation LTLiveBroadcastViewController

static NSString * const reuseIdentifier = @"LiveBroadcastCell";

#pragma mark - ViewLife

- (instancetype)init{
    //载入FlowLayout
    return [super initWithCollectionViewLayout:[[LTLiveBroadcastLayout alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[LTLiveBroadcastCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    LTRefreshGifHeader *headerView = [LTRefreshGifHeader headerWithRefreshingBlock:^{
        [self.collectionView.mj_header endRefreshing];
        self.currentIndex++;
        if (self.currentIndex == self.lives.count) { self.currentIndex = 0; }
        [self.collectionView reloadData];
    }];
    headerView.stateLabel.hidden = NO;
    [headerView setTitle:@"下拉切换另一个主播" forState:MJRefreshStatePulling];
    [headerView setTitle:@"下拉切换另一个主播" forState:MJRefreshStateIdle];
    self.collectionView.mj_header = headerView;
    
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LTLiveBroadcastCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.parentVC = self;
    cell.lives = self.lives[self.currentIndex];
    // 设置相关主播的index(待完成)
    // 设置相关主播click的block(待完成)
    return cell;
}

#pragma mark - <UICollectionViewDelegate>



@end
