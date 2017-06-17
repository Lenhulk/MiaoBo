//
//  LTTopADs.h
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/1.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTTopADs : NSObject

//--------轮播器需要的参数---------//
/**ad图片(.jpg)*/
@property (nonatomic, copy) NSString     *imageUrl;
/**链接(.aspx)*/
@property (nonatomic, copy) NSString     *link;
/**ad序号*/
@property (nonatomic, assign) NSInteger  orderid;
/**ad名*/
@property (nonatomic, copy) NSString     *title;

//--------点击跳转进入直播---------//
/**直播流*/
@property (nonatomic, copy) NSString     *flv;
/**所在城市*/
@property (nonatomic, copy) NSString     *gps;
/** 主播ID */
@property (nonatomic, copy) NSString     *useridx;
/**主播名*/
@property (nonatomic, copy) NSString     *myname;
/** 个性签名 */
@property (nonatomic, copy) NSString     *signatures;
/** 主播头像 */
@property (nonatomic, copy) NSString     *smallpic;
/**房间号*/
@property (nonatomic, copy) NSString     *roomid;
/** 所在服务器号 */
@property (nonatomic, assign) NSUInteger serverid;
/** 当前状态 */
@property (nonatomic, assign) NSUInteger state;

//--------好像没什么用的参数---------//
/**新增时间*/
@property (nonatomic, copy) NSString     *addTime;
/**倒计时*/
@property (nonatomic, assign) NSInteger  cutTime;
/** 大图 */
@property (nonatomic, copy  ) NSString   *bigpic;
/** 不知道什么鬼 */
@property (nonatomic, copy  ) NSString   *hiddenVer;
/** 不知道什么鬼 */
@property (nonatomic, copy  ) NSString   *lrCurrent;


@end
