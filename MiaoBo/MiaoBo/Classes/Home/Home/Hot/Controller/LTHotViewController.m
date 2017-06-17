//
//  LTHotViewController.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/1.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTHotViewController.h"
#import "LTHomeADCell.h"
#import "LTHotLiveCell.h"
#import "LTWebView.h"
#import "LTTopADs.h"
#import "LTLives.h"
#import "LTNetworkTool.h"
#import "LTRefreshGifHeader.h"
#import "UIViewController+LTHUD.h"
#import <MJExtension/MJExtension.h>
#import "LTLiveBroadcastViewController.h"

static NSString *adReuserID = @"ADCell";
static NSString *liveReuserID = @"liveCell";

@interface LTHotViewController ()
@property (nonatomic, strong) NSArray *topADs;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *lives;
@end

@implementation LTHotViewController

#pragma mark - 懒加载

- (NSArray *)topADs{
    if (!_topADs) {
        _topADs = [NSArray array];
    }
    return _topADs;
}

- (NSMutableArray *)lives{
    if (!_lives) {
        _lives = [NSMutableArray array];
    }
    return _lives;
}

#pragma mark - VIEWLIVE

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupRefreshView];
    [self getADInfo];
}

- (void)setupTableView{
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[LTHomeADCell class] forCellReuseIdentifier:adReuserID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTHotLiveCell class]) bundle:nil] forCellReuseIdentifier:liveReuserID];
}

- (void)setupRefreshView{
    self.currentPage = 1;
    
    self.tableView.mj_header = [LTRefreshGifHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self getADInfo];
        [self getHotLivesList];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self getHotLivesList];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - NETWORK

///获取广告数据
- (void)getADInfo{
    [[LTNetworkTool shareTool] GET:KGetTopADsUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        LTLog(@"%@", responseObject);
        
        NSArray *ads = responseObject[@"data"];
        if ([self isArrayNotEmpty:ads]){
            self.topADs = [LTTopADs mj_objectArrayWithKeyValuesArray:ads];
            [self.tableView reloadData];
        } else {
            [self showHint:@"未知错误，获取ADs失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"%@", error);
        [self showHint:@"网络错误"];
    }];
}

///获取直播列表数据
- (void)getHotLivesList{
    [[LTNetworkTool shareTool] GET:[NSString stringWithFormat:KHotLivesUrl, self.currentPage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LTLog(@"\nRESPONSE\n%@", responseObject);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSArray *livesArr = [LTLives mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];;
        if ([self isArrayNotEmpty:livesArr]) {
            [self.lives addObjectsFromArray:livesArr];
            [self.tableView reloadData];
        } else {
            self.currentPage--;
            [self showHint:@"暂时没有更多的数据哦~"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"%@", error);
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.currentPage--;
        [self showHint:@"网络错误，获取数据异常"];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lives.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {   //广告
        return 100;
    }
    return 465;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //广告的cell
    if (indexPath.row == 0) {
        LTHomeADCell *cell = [tableView dequeueReusableCellWithIdentifier:adReuserID];
        if (self.topADs.count) {
            cell.topADs = self.topADs;
            
                //设置广告点击跳转的block
            [cell setAdImageClickBlock:^(LTTopADs *topADs){
                NSString *link = topADs.link;
                if (link.length) {
                    LTWebView *webView = [[LTWebView alloc] initWithUrlString:link];
                    webView.navigationItem.title = topADs.title;
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyHideTopMenu object:self];
                    [self.navigationController pushViewController:webView animated:YES];
                }
            }];
        }
        return cell;
    }
    
    //自定义的cell
    LTHotLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:liveReuserID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.lives.count) {
        LTLives *live = self.lives[indexPath.row - 1];  //记得减去广告那一个，否则最后一个cell获取不到数据崩溃
        cell.lives = live;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到直播
    LTLiveBroadcastViewController *liveVc = [[LTLiveBroadcastViewController alloc] init];
    liveVc.lives = self.lives;
    liveVc.currentIndex = indexPath.row - 1;
    //直播页面不用push，因为需要隐藏顶部TabBar，用present
//    [self.navigationController pushViewController:liveVc animated:YES];
    [self presentViewController:liveVc animated:YES completion:nil];
}


@end
