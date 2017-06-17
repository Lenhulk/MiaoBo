//
//  LTHotLiveCell.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/2.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTHotLiveCell.h"
#import "UIImageView+WebCache.h"
#import "LTLives.h"
#import "UIImage+LTExtension.h"

@interface LTHotLiveCell ()
@property (weak, nonatomic) IBOutlet UIImageView    *headImageView;
@property (weak, nonatomic) IBOutlet UILabel        *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *levelImageView;
@property (weak, nonatomic) IBOutlet UIButton       *locationButton;
@property (weak, nonatomic) IBOutlet UILabel        *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *bigPicImageView;

@end


@implementation LTHotLiveCell

- (void)setLives:(LTLives *)lives{
    
    _lives = lives;
    
    // 头像
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:lives.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head_100x100_"] options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //裁剪圆头像
        image = [UIImage circleImage:image borderColor:KBorderColor borderWidth:4];
        self.headImageView.image = image;
    }];
    
    // 主播名
    self.nameLabel.text = lives.myname;
    
    // 等级图标
    NSString *starImgName = [NSString stringWithFormat:@"girl_star%ld_40x19_", lives.starlevel];
    UIImage *starImg = [UIImage imageNamed:starImgName];
    self.levelImageView.image = starImg;
    
    // 直播地点
    if (!lives.gps.length) { lives.gps = @"喵星"; }
    [self.locationButton setTitle:lives.gps forState:UIControlStateNormal];
    
    // 观众数(修改显示样式)
    NSString *countLabelStr = [NSString stringWithFormat:@"%ld人正在观看", lives.allnum];
    NSRange range = [countLabelStr rangeOfString:[NSString stringWithFormat:@"%ld", lives.allnum]];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:countLabelStr];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:range];
    [attrStr addAttribute:NSForegroundColorAttributeName value:KKeyColor range:range];
    self.countLabel.attributedText = attrStr;
    
    // 封面图
    [self.bigPicImageView sd_setImageWithURL:[NSURL URLWithString:lives.bigpic] placeholderImage:[UIImage imageNamed:@"profile_user_375x375_"] options:SDWebImageLowPriority completed:nil];
}

@end
