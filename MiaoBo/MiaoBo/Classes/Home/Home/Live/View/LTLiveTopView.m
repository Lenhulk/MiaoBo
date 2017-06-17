//
//  LTLiveTopView.m
//  MiaoBo
//
//  Created by 零號叔叔 on 2017/4/10.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTLiveTopView.h"
#import <MJExtension.h>
#import "LTAnchors.h"
#import "LTLives.h"
#import "UIView+LTExtension.h"
#import "UIImage+LTExtension.h"
#import <UIImageView+WebCache.h>
#import "MarqueeLabel.h"

@interface LTLiveTopView ()
/** 用户信息 */
@property (weak, nonatomic) IBOutlet UIView *anchorView;
/** 礼物信息 */
@property (weak, nonatomic) IBOutlet UIButton *giftView;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
/** 滚动的名字label */
@property (weak, nonatomic) IBOutlet MarqueeLabel *nameLabel;
/** 观众数量 */
@property (weak, nonatomic) IBOutlet UILabel *audienceCount;
/** 点击关注*/
@property (weak, nonatomic) IBOutlet UIButton *careButton;
/** 关联主播的头像们 */
@property (weak, nonatomic) IBOutlet UIScrollView *usersScrollView;
/** 存放scrollView里的模型数据 */
@property (strong, nonatomic) NSArray *chaoyangUsers;
@end

@implementation LTLiveTopView

#pragma mark - Lazy Load

- (NSArray *)chaoyangUsers{
    if (!_chaoyangUsers) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"plist"];
        _chaoyangUsers = [LTAnchors mj_objectArrayWithFile:path];
    }
    return _chaoyangUsers;
}

#pragma mark - View Life

+ (instancetype)liveTopView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupTopView];
}

#pragma mark - Setup

/// 设置顶部View的子控件
- (void) setupTopView{
    
    [self setupCareButton];
    
    self.nameLabel.marqueeType = MLLeftRight;
    self.nameLabel.fadeLength = 5.0f;
    self.nameLabel.animationDelay = 3.0;
    
    [self makeViewToBounds:self.anchorView];
    [self makeViewToBounds:self.giftView];
    [self makeViewToBounds:self.careButton];
    [self makeViewToBounds:self.headImgView];
    
    [self setupHeadImageView];
    [self setupUsersScrollView];
}

- (void) setupCareButton{
    [self.careButton setBackgroundImage:[UIImage imageWithColor:KBorderColor size:self.careButton.size] forState:UIControlStateNormal];
    [self.careButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] size:self.careButton.size] forState:UIControlStateSelected];
    //设置默认是"未点击"
    [self clickCareBtn:self.careButton];
}

- (void) setupHeadImageView{
    self.headImgView.userInteractionEnabled = YES;
    self.headImgView.layer.borderWidth = 1;
    self.headImgView.layer.borderColor = KBorderColor.CGColor;
    [self.headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUserScrollHead:)]];
}

- (void) setupUsersScrollView{
    CGFloat wh = self.usersScrollView.height - 10;
    self.usersScrollView.contentSize = CGSizeMake((wh + KDefaultMargin) * self.chaoyangUsers.count, 0);
    self.usersScrollView.showsHorizontalScrollIndicator = NO;
    
    CGFloat x = 0;
    CGFloat y = (self.usersScrollView.height - wh) * 0.5;
    for (int i = 0 ; i < self.chaoyangUsers.count; i++) {
        x = (wh + KDefaultMargin) * i;
        UIImageView *headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, wh, wh)];
        [self makeViewToBounds:headImgV];
        LTAnchors *anchor = self.chaoyangUsers[i];
        
        NSURL *url = [NSURL URLWithString:anchor.photo];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                headImgV.image = image;
            });
        }];
        
        //设置头像的点击监听
        headImgV.userInteractionEnabled = YES;
        headImgV.tag = i;
        [headImgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUserScrollHead:)]];
        [self.usersScrollView addSubview:headImgV];
    }
}



#pragma mark - Setter

- (void)setLive:(LTLives *)live{
    _live = live;
    
    self.nameLabel.text = live.myname;
    
    NSURL *url = [NSURL URLWithString:live.smallpic];
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.headImgView.image = image;
        });
    }];
    
    self.audienceCount.text = [NSString stringWithFormat:@"%ld人", live.allnum];
}

#pragma mark - Private Function

///给控件裁圆角
- (void)makeViewToBounds:(UIView *)view{
    view.layer.cornerRadius = view.height * 0.5;
    view.layer.masksToBounds = YES;
}

///点击头像时给需要弹出的主播详情View赋值
- (void)clickUserScrollHead:(UITapGestureRecognizer *)tapGes{
    if (tapGes.view == self.headImgView) {
        // TD---发通知
        LTLog(@"你点了当前主播的头像");
    } else {
        // TD---发通知
        LTLog(@"点击了UserScrollView的头像");
    }
}

///点击了关注
- (IBAction)clickCareBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    sender.titleLabel.text = @"已关注";
    if (self.careBtnClick) {
        self.careBtnClick(sender.selected);
    }
}





@end
