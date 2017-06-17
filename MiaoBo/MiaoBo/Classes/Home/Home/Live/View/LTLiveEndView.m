//
//  LTLiveEndView.m
//  MiaoBo
//
//  Created by 零號叔叔 on 2017/4/9.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTLiveEndView.h"

@interface LTLiveEndView ()
@property (weak, nonatomic) IBOutlet UIButton *careButton;
@property (weak, nonatomic) IBOutlet UIButton *watchOtherButton;
@property (weak, nonatomic) IBOutlet UIButton *leaveButton;

@end

@implementation LTLiveEndView

+ (instancetype)liveEndView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    //给按钮设置圆角
    self.careButton.layer.cornerRadius = self.careButton.height * 0.5;
    self.careButton.layer.masksToBounds = YES;
    self.careButton.layer.borderWidth = 1;
    self.careButton.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
}

- (IBAction)careAnchor:(UIButton *)sender {
    [sender setTitle:@"关注成功" forState:UIControlStateNormal];
}

- (IBAction)watchOtherAnchor:(id)sender {
    [self removeFromSuperview];
    if (self.watchOtherBlock) {
        self.watchOtherBlock();
    }
}

- (IBAction)leaveRoom:(id)sender {
    if (self.leaveRoomBlock){
        self.leaveRoomBlock();
    }
}


@end
