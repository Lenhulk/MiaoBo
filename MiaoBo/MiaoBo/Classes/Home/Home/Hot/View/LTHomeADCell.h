//
//  LTHomeADCell.h
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/1.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRCarouselView.h"

@class LTTopADs;
@interface LTHomeADCell : UITableViewCell <XRCarouselViewDelegate>

/**顶部广告数组*/
@property (nonatomic, strong) NSArray *topADs;

/**点击图片的block*/
@property (nonatomic, strong) void (^adImageClickBlock)(LTTopADs *topADs);

@end
