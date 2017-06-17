//
//  LTLiveBroadcastViewController.h
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/3.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTLives;

@interface LTLiveBroadcastViewController : UICollectionViewController

/** 直播模型 */
@property (nonatomic, strong) NSArray *lives;

/** 当前index */
@property (nonatomic, assign) NSInteger currentIndex;

@end
