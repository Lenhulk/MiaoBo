//
//  LTAnchors.h
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/13.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//  最新主播模型

#import <Foundation/Foundation.h>

@interface LTAnchors : NSObject


//"lianMaiStatus": 0,
//"phonetype": 0,
//"isOnline": 0

/**昵称*/
@property (nonatomic, copy) NSString *nickname;
/**直播地址*/
@property (nonatomic, copy) NSString *flv;
/**封面图片地址*/
@property (nonatomic, copy) NSString *photo;
/**所在地址*/
@property (nonatomic, copy) NSString *position;
/**房间号*/
@property (nonatomic, copy) NSString *roomid;
/**用户id*/
@property (nonatomic, copy) NSString *useridx;
/**服务器号*/
@property (nonatomic, assign) NSInteger serverid;
/**性别*/
@property (nonatomic, assign) NSInteger sex;
/**是否新人*/
@property (nonatomic, assign) NSInteger newStar;
/**等级*/
@property (nonatomic, assign) NSInteger starlevel;
/** 朝阳群众数目 */
@property (nonatomic, assign) NSUInteger allnum;

@end
