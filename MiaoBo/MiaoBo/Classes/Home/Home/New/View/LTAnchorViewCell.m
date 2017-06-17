//
//  LTAnchorViewCell.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/13.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTAnchorViewCell.h"
#import "LTAnchors.h"
#import "UIImageView+WebCache.h"

@interface LTAnchorViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *tagImgV;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerImgV;
@property (weak, nonatomic) IBOutlet UILabel *nickNameL;
@end

@implementation LTAnchorViewCell

- (void)setAnchors:(LTAnchors *)anchors{
    
    _anchors = anchors;

    [_headerImgV sd_setImageWithURL:[NSURL URLWithString:anchors.photo]];
    
    if ([anchors.position  isEqual: @""]) {
        anchors.position = @"🌍未知";
    }
    [self.locationBtn setTitle:anchors.position forState:UIControlStateNormal];
    
    self.tagImgV.hidden = !anchors.newStar;
    
    self.nickNameL.text = anchors.nickname;
}

@end
