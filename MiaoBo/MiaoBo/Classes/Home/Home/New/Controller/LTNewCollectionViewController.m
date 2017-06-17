//
//  LTNewCollectionViewController.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/12.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTNewCollectionViewController.h"
#import "LTNewFlowLayout.h"
#import <MJExtension/MJExtension.h>
#import "LTAnchors.h"
#import "LTAnchorViewCell.h"
#import "LTRefreshGifHeader.h"
#import "LTNetworkTool.h"
#import "UIViewController+LTHUD.h"
#import "LTLiveBroadcastViewController.h"
#import "LTLives.h"

@interface LTNewCollectionViewController ()
/**最新主播列表*/
@property (nonatomic, strong) NSMutableArray *anchors;
/**当前页*/
@property (nonatomic, assign) NSInteger currentPage;
@end

static NSString * const reuseIdentifier = @"NewStarCell";

@implementation LTNewCollectionViewController

#pragma mark - 懒加载

- (NSMutableArray *)anchors{
    if (!_anchors) {
        _anchors = [NSMutableArray array];
    }
    return _anchors;
}

#pragma mark - ViewControllerLifeLine

- (instancetype)init{
    //创建的时候设置FlowLayout
    return [super initWithCollectionViewLayout:[[LTNewFlowLayout alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentPage = 1;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册cell
    //    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LTAnchorViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self setupRefreshView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //界面将要展示时调用头部刷新获取网络数据(page == 1)
    [self.collectionView.mj_header beginRefreshing];
}


#pragma mark - 网络数据 & 刷新控件

///设置两个刷新控件
- (void)setupRefreshView{
    
    self.collectionView.mj_header = [LTRefreshGifHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self getAnchorsList];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage ++;
        [self getAnchorsList];
    }];
    
}

/// 获取网络数据
- (void)getAnchorsList{
    [[LTNetworkTool shareTool] GET:[NSString stringWithFormat:KNewStarsUrl, self.currentPage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        LTLog(@"\nRESPONSE:\n%@", responseObject);
        
        //结束刷新
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        //收到响应但是失败了（到达尾页）
        if ([responseObject[@"msg"] isEqualToString:@"fail"]){
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            self.currentPage--;
            [self showHint:@"别拉了！暂时没有更多的主播啦~"];
        } else {
            
        //正常接收到响应数据
            NSDictionary *responDic = responseObject[@"data"][@"list"];
            NSArray *resArr = [LTAnchors mj_objectArrayWithKeyValuesArray:responDic];
            if (resArr.count) {
                //赋值并刷新界面
                LTLog(@"当前页%ld", _currentPage);
                [self.anchors addObjectsFromArray:resArr];
                [self.collectionView reloadData];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"\n获取网络数据错误：\n%@", error);
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.currentPage--;
        [self showHint:@"网络异常，请检查"];
    }];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.anchors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = KRandomColor;
    
    LTAnchorViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.anchors = self.anchors[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LTLog(@"&&&&&&&&&&&&&&&&&%ld", indexPath.item);
    LTLiveBroadcastViewController *liveBroadcastVc = [[LTLiveBroadcastViewController alloc] init];
    NSMutableArray *liveModels = [NSMutableArray array];
    for (LTAnchors *anchor in self.anchors) {
        LTLives *live = [[LTLives alloc] init];
        live.flv = anchor.flv;
        live.gps = anchor.position;
        live.bigpic = anchor.photo;
        live.myname = anchor.nickname;
        live.allnum = anchor.allnum;
        live.useridx = anchor.useridx;
        [liveModels addObject:live];
    }
    liveBroadcastVc.lives = liveModels;
    liveBroadcastVc.currentIndex = indexPath.item;
    [self presentViewController:liveBroadcastVc animated:YES completion:nil];
}

@end
