//
//  LTLiveBroadcastCell.h
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/3.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTLives;

@interface LTLiveBroadcastCell : UICollectionViewCell
/** 直播 */
@property (nonatomic, strong) LTLives *lives;
/** 相关的直播 */
@property (nonatomic, strong) LTLives *relateLive;
/** 父控制器 */
@property (nonatomic, weak) UIViewController *parentVC;
/** 点击关联的主播 */


@end
