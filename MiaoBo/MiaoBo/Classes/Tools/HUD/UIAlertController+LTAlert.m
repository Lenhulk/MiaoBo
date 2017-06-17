//
//  UIAlertController+LTAlert.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/11.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "UIAlertController+LTAlert.h"

@implementation UIAlertController (LTAlert)

+ (UIAlertController *)showAlert:(NSString *)info{
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"喵播提示" message:info preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [controller addAction:action];
    
    return controller;
}

//+ (UIAlertController *)showActionSheet:(NSString *)info{
//    
//    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"喵播提示" message:info preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//    
//    [controller addAction:action];
//    
//    return controller;
//}


@end
