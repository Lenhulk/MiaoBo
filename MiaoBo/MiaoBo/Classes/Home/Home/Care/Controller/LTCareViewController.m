//
//  LTCareViewController.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/12.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTCareViewController.h"



@interface LTCareViewController ()
@property (weak, nonatomic) IBOutlet UIButton *toSeeBtn;

@end

@implementation LTCareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toSeeBtn.layer.cornerRadius = self.toSeeBtn.height * 0.5;
    self.toSeeBtn.layer.borderColor = KKeyColor.CGColor;
    self.toSeeBtn.layer.borderWidth = 1;
    [self.toSeeBtn.layer masksToBounds];
    
    [self.toSeeBtn setTitleColor:KKeyColor forState:UIControlStateNormal];
}



- (IBAction)toSeeHotLiving:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyToseeBigWorld object:nil];
}


@end
