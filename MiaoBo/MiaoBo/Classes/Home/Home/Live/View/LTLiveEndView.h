//
//  LTLiveEndView.h
//  MiaoBo
//
//  Created by 零號叔叔 on 2017/4/9.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//  直播结束的VIew

#import <UIKit/UIKit.h>

@interface LTLiveEndView : UIView
+ (instancetype) liveEndView;
/** 查看其他主播 */
@property (nonatomic, copy) void (^watchOtherBlock)();
/** 退出直播间 */
@property (nonatomic, copy) void (^leaveRoomBlock)();
@end
