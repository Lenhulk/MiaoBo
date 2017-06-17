//
//  LTShowTimeViewController.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/11.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTShowTimeViewController.h"

@interface LTShowTimeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *beautyButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *startLiving;

@end

@implementation LTShowTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.beautyButton.layer.cornerRadius = 5;
}

- (IBAction)changeBeautyMode:(UIButton *)sender {
    self.beautyButton.selected = !sender.selected;
    LTLog(@"切换美颜效果");
}

- (IBAction)exchangeCamera:(id)sender {
    LTLog(@"切换前后摄像头");
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)startLiving:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        LTLog(@"开始直播..");
    } else {
        LTLog(@"结束直播！");
    }
    
}

@end
