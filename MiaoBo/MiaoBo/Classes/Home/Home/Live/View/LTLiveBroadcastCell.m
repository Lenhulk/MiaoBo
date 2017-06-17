//
//  LTLiveBroadcastCell.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/3.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTLiveBroadcastCell.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "LTMoviePlayerController.h"
#import "LTLives.h"
#import "UIViewController+LTExtension.h"
#import <SDWebImageDownloader.h>
#import <UIImageView+WebCache.h>
#import "UIImage+LTExtension.h"
#import "LTNetworkTool.h"
#import "LTLiveEndView.h"
#import "LTLiveBottomToolView.h"
#import "LTLiveTopView.h"

@interface LTLiveBroadcastCell ()
/** 直播播放器 */
@property (nonatomic, strong) LTMoviePlayerController *moviePlayer;
/** 直播前占位图片 */
@property (nonatomic, weak) UIImageView *placeHolderImgV;
/** 直播结束画面 */
@property (nonatomic, weak) LTLiveEndView *endView;
/** 直播底部工具栏 */
@property (nonatomic, weak) LTLiveBottomToolView *toolView;
/** 直播顶部视图 */
@property (nonatomic, weak) LTLiveTopView *topView;
@end

static CGFloat toolViewH = 50;

@implementation LTLiveBroadcastCell

#pragma mark - Lazy Load

- (UIImageView *)placeHolderImgV{
    if (!_placeHolderImgV) {
        //设置imageView
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.image = [UIImage imageNamed:@"profile_user_414x414_"];
        imgV.frame = self.contentView.bounds;
        [self.contentView addSubview:imgV];
        _placeHolderImgV = imgV;
        //获取父控制器，展示加载动画
        [self.parentVC showGifLoding:nil inView:self.placeHolderImgV];
        //强制布局
        [_placeHolderImgV layoutIfNeeded];
    }
    return _placeHolderImgV;
}

- (LTLiveTopView *)topView{
    if (!_topView) {
        LTLiveTopView *topV = [LTLiveTopView liveTopView];
        topV.frame = CGRectMake(0, 0, KScreenW, 60);
        [topV setCareBtnClick:^(bool isSelected){
            if (_moviePlayer) {
                _moviePlayer.shouldShowHudView = !isSelected;
                LTLog(@"%d", isSelected);
            }
        }];
        [self.contentView insertSubview:topV aboveSubview:self.placeHolderImgV];
        _topView = topV;
    }
    return _topView;
}

- (LTLiveBottomToolView *)toolView{
    if (!_toolView) {
        LTLiveBottomToolView *toolV = [[LTLiveBottomToolView alloc] initWithFrame:CGRectMake(0, KScreenH - toolViewH, KScreenW, toolViewH)];
        [toolV setClickToolBlock:^(LiveToolType type){
            switch (type) {
                case LiveToolTypePublicTalk:
                    break;
                case LiveToolTypePrivateTalk:
                    break;
                case LiveToolTypeGift:
                    break;
                case liveToolTypeTreasure:
                    break;
                case LiveToolTypeRank:
                    break;
                case LiveToolTypeShare:
                    break;
                case LiveToolTypeClose:
                    [self leaveRoom];
                    break;
                default:
                    break;
            }
        }];
        [self.contentView insertSubview:toolV aboveSubview:self.placeHolderImgV];
        _toolView = toolV;
    }
    return _toolView;
}

- (LTLiveEndView *)endView{
    if (!_endView) {
        LTLiveEndView *endV = [LTLiveEndView liveEndView];
        [endV setWatchOtherBlock:^{
            [self clickCatEar];
        }];
        [endV setLeaveRoomBlock:^{
            [self leaveRoom];
        }];
        [self.contentView addSubview:endV];
        _endView = endV;
    }
    return _endView;
}

#pragma mark - SETTER方法

- (void)setLives:(LTLives *)lives{
    _lives = lives;
    
    //给顶部主播头像栏赋值(待完成)
    self.topView.live = lives;
    
    //设置直播流
    [self placeFLV:lives.flv placeHolderImgUrl:lives.bigpic];
}

#pragma mark - View Life

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.topView.hidden = NO;
        self.toolView.hidden = NO;
    }
    return self;
}

#pragma mark - Private Method

- (void)placeFLV:(NSString *)flv placeHolderImgUrl:(NSString *)phImgUrl{
    //关闭上一个player
    
    //如果切换主播, 取消之前的动画
    
    //加载动画
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:phImgUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.parentVC showGifLoding:nil inView:self.placeHolderImgV];
            self.placeHolderImgV.image = [UIImage blurImage:image blur:0.6];
        });
    }];
    
    //创建播放器
    LTMoviePlayerController *moviePlayer = [LTMoviePlayerController moviePlayerWithFlv:flv];
    moviePlayer.view.frame = self.contentView.bounds;
    
    //准备播放
    [self.contentView insertSubview:moviePlayer.view atIndex:0];
    self.moviePlayer = moviePlayer;

    //添加播放器监听
    [self initPlayerObserver];
}

- (void)initPlayerObserver{
    
    //监听是否播放完毕或者被关闭
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackDidFinished) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
    //监听加载是视频状态改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadStateDidChanged) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (void)loadStateDidChanged{
    // 判断是否准备就绪
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        // 判断是否没有正在播放 (开始播放 去掉动画)
        LTLog(@"就绪>开始播放");
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_placeHolderImgV) {
                    [_placeHolderImgV removeFromSuperview];
                    _placeHolderImgV = nil;
                }
                [self.parentVC hideGifLoding];
            });
        } else {
            // 如果是正在播放,但网络状态不好(改变), 断开后再加载, 也要去掉动画
            LTLog(@"从网速不佳>到缓冲成功!");
            if (self.parentVC.gifView.isAnimating){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.parentVC hideGifLoding];
                });
            }
        }
    } else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){
        // 网速不佳, 自动暂停了, 添加上GIF动画
        LTLog(@"网速不佳>自动暂停...");
        [self.parentVC showGifLoding:nil inView:self.moviePlayer.view];
    }
}

- (void)playbackDidFinished{
    // 因为网速或者其他原因导致直播stop了(暂停状态)
    LTLog(@"加载状态 %ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled && !self.parentVC.gifView){
        [self.parentVC showGifLoding:nil inView:self.moviePlayer.view];
        return ;
    }
    // 重新请求该地址，若请求成功表示直播未结束，否则结束
    LTLog(@"重新请求");
    __weak typeof(self) weakSelf = self;
    [[LTNetworkTool shareTool] GET:self.lives.flv parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LTLog(@"请求成功, 等待继续播放-------%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"请求失败, 加载失败界面, 关闭播放器------%@", error);
        [weakSelf.moviePlayer shutdown];
        [weakSelf.moviePlayer.view removeFromSuperview];
        weakSelf.moviePlayer = nil;
        //展示结束画面
        self.endView.hidden = NO;
    }];
}

/// 点击了猫耳朵(观看其他主播)
- (void)clickCatEar{
            LTLog(@"进入其他block");
}

/// 离开房间
- (void)leaveRoom{
    if (_moviePlayer) {
        [self.moviePlayer shutdown];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self.parentVC dismissViewControllerAnimated:YES completion:nil];
}



@end
