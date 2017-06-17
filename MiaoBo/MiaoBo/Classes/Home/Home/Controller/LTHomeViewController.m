//
//  LTHomeViewController.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/11.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTHomeViewController.h"
#import "LTTopMenuView.h"
#import "LTWebView.h"
#import "LTHotViewController.h"
#import "LTNewCollectionViewController.h"
#import "LTCareViewController.h"

static NSString * const CELLID = @"CollectionCell";

@interface LTHomeViewController () <UIScrollViewDelegate>
/** 顶部选择视图 */
@property (nonatomic, strong) LTTopMenuView *topMenuView;
/** 平铺导航容器 */
@property (nonatomic, strong) UIScrollView *containerView;
/** 子控制器们*/
@property (nonatomic, strong) LTHotViewController *hotVC;
@property (nonatomic, strong) LTNewCollectionViewController *starVC;
@property (nonatomic, strong) LTCareViewController *careVC;
@end

@implementation LTHomeViewController

#pragma mark - ViewLife

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航控制器控件
    [self setupNavigator];
    
    // 设置底部容器view
    [self setupContainerView];
    
    // 设置所有子控制器
    [self setupAllChildViewController];
    
    //监听顶部菜单隐藏事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTopMenuView) name:kNotifyHideTopMenu object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (!_topMenuView) {
        [self setupTopMenuView];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - SETUP

- (void)setupAllChildViewController{
    
    CGFloat height = KScreenH - 49;

    LTHotViewController *hot = [[LTHotViewController alloc] init];
    hot.view.frame = KScreenBounds;
    hot.view.height = height;
    [self addChildViewController:hot];
    [_containerView addSubview:hot.view];
    _hotVC = hot;
    
    LTNewCollectionViewController *newStar = [[LTNewCollectionViewController alloc] init];
    newStar.view.frame = KScreenBounds;
    newStar.view.x = KScreenW;
    newStar.view.height = height;
    [self addChildViewController:newStar];
    [_containerView addSubview:newStar.view];
    _starVC = newStar;
    
    LTCareViewController *care = [UIStoryboard storyboardWithName:NSStringFromClass([LTCareViewController class]) bundle:nil].instantiateInitialViewController;
    care.view.frame = KScreenBounds;
    care.view.x = KScreenW * 2;
    care.view.height = height;
    [self addChildViewController:care];
    [_containerView addSubview:care.view];
    _careVC = care;

}

- (void)setupNavigator{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStylePlain target:self action:@selector(jump2rankCrown)];
    [self setupTopMenuView];
}

- (void)setupTopMenuView{
    
    /// 设置顶部滑动自定义导航条
    LTTopMenuView *topView = [[LTTopMenuView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    topView.x = Home_Seleted_Item_LRW;
    topView.width = KScreenW - Home_Seleted_Item_LRW * 2;
    
    // 利用block监听点击回调的type并 触发collectionView滑动到对应位置 cv滑动时进入代理方法
    [topView setSelectedBlock:^(HomeType type) {
        CGFloat offset = type * KScreenW;
        [self.containerView setContentOffset:CGPointMake(offset, 0) animated:YES];
    }];
    
    self.topMenuView = topView;
    [self.navigationController.navigationBar addSubview:topView];
}

- (void)setupContainerView{
    
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:KScreenBounds];
    view.contentSize = CGSizeMake(KScreenW * 3, 0);
    view.backgroundColor = [UIColor lightGrayColor];
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    view.pagingEnabled = YES;
    view.delegate = self;
    view.bounces = NO;
    self.view = view;
    self.containerView = view;
}

#pragma mark - OTHER

///移除顶部视图
- (void)removeTopMenuView{
    [self.topMenuView removeFromSuperview];
    self.topMenuView = nil;
}

- (void)jump2rankCrown{
    
    LTWebView *webView = [[LTWebView alloc] initWithUrlString:KRangeCrownUrl];
    webView.navigationItem.title = @"排行";
    [self removeTopMenuView];
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark - DELEGATE & DATASOURCE

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat page = scrollView.contentOffset.x / KScreenW;
    
    //使下划线滚动
    CGFloat offsetX = page * (self.topMenuView.width * 0.5 - Home_Seleted_Item_W * 0.5 - 15);
    self.topMenuView.underLine.x = 15 + offsetX;
    if (page == 1) {
        self.topMenuView.underLine.x = offsetX + 10;
    }else if (page > 1){
        self.topMenuView.underLine.x = offsetX + 5;
    }
    //传入topView type 使按钮选中
    self.topMenuView.selectedType = (int)(page + 0.5);
}

@end
