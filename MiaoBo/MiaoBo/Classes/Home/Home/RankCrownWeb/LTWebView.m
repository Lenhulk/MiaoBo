//
//  LTWebView.m
//  MiaoBo
//
//  Created by Lenhulk on 2017/3/12.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTWebView.h"

@interface LTWebView ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation LTWebView

/// 懒加载
- (UIWebView *)webView{
    if (!_webView) {
        
        UIWebView *webV = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webV.scrollView.showsVerticalScrollIndicator = NO;
        webV.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        [self.view addSubview:webV];
        _webView = webV;
        
    }
    return _webView;
}

/// 根据URL加载网页
- (instancetype)initWithUrlString:(NSString *)urlStr{
    if (self = [self init]) {
        
        NSURL *url = [NSURL URLWithString:urlStr];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        
    }
    return self;
}

@end
