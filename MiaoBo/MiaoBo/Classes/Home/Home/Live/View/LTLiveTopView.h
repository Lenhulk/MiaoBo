//
//  LTLiveTopView.h
//  MiaoBo
//
//  Created by 零號叔叔 on 2017/4/10.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTLives;
@class LTAnchors;

@interface LTLiveTopView : UIView

/** 直播模型 */
@property (nonatomic, strong) LTLives *live;
/** 顶部用户头像模型 */
@property (nonatomic, strong) LTAnchors *anchors;
/** 点击开关(关注) */
@property (nonatomic, copy) void (^careBtnClick)(bool selected);
/** 工厂方法 */
+ (instancetype)liveTopView;

@end
