//
//  LTLiveBottomToolView.h
//  MiaoBo
//
//  Created by 零號叔叔 on 2017/4/9.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//  直播底部工具栏

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LiveToolType) {
    LiveToolTypePublicTalk,
    LiveToolTypePrivateTalk,
    LiveToolTypeGift,
    liveToolTypeTreasure,
    LiveToolTypeRank,
    LiveToolTypeShare,
    LiveToolTypeClose
};

@interface LTLiveBottomToolView : UIView
/** 点击工具栏 */
@property (nonatomic, copy) void (^clickToolBlock)(LiveToolType type);
@end
