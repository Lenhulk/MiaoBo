//
//  LTNetworkTool.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/4/1.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTNetworkTool.h"

@implementation LTNetworkTool

static LTNetworkTool *_manager;

+ (instancetype)shareTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [LTNetworkTool manager];
        
        //设置超时时间
        _manager.requestSerializer.timeoutInterval = 5.f;
        
        //添加自定义的MIME types
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _manager;
}


@end
