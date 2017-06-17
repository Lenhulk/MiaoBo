//
//  Macro.h
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/12.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//  应用的宏

#ifndef Macro_h
#define Macro_h

///设备
#define KIsSimulator @"iPhone Simulator"

///屏幕尺寸
#define KScreenBounds [UIScreen mainScreen].bounds
#define KScreenSize KScreenBounds.size
#define KScreenW KScreenSize.width
#define KScreenH KScreenSize.height
#define KDefaultMargin 10

// 首页的选择器
#define Home_Seleted_Item_W     60
#define Home_Seleted_Item_M     10
#define Home_Seleted_Item_LRW   45
#define Home_Seleted_W          KScreenW - Home_Seleted_Item_LRW * 2
#define Home_Seleted_OffsetX(page)  5+5*(page) + (page) * (Home_Seleted_W * 0.5 - Home_Seleted_Item_W * 0.5 - 15)

///颜色
#define LTColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
#define KKeyColor LTColor(216, 41, 116, 1)
#define KBorderColor LTColor(210, 35, 110, 1)
#define KRandomColor LTColor(arc4random_uniform(255.0),arc4random_uniform(255.0),arc4random_uniform(255.0),1)

/// 通知
// 隐藏TopMenuView
#define kNotifyHideTopMenu @"kNotifyHideTopMenu"
// 当前没有关注的主播, 去看热门主播
#define kNotifyToseeBigWorld @"kNotifyToseeBigWorld"
// 当前的直播控制器即将消失
#define kNotifyLiveWillDisappear @"kNotifyLiveWillDisappear"
// 点击了用户
#define kNotifyClickUser @"kNotifyClickUser"
// 自动刷新最新主播界面
#define kNotifyRefreshNew @"kNotifyRefreshNew"

///网络请求
#define KGetTopADsUrl   @"http://live.9158.com/Living/GetAD"
#define KHotLivesUrl    @"http://live.9158.com/Fans/GetHotLive?page=%ld"
#define KNewStarsUrl    @"http://live.9158.com/Room/GetNewRoomOnline?page=%ld"
#define KRangeCrownUrl  @"http://live.9158.com/Rank/WeekRank?Random=10"

#endif /* Macro_h */
