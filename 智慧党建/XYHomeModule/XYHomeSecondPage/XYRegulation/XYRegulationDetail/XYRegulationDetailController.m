//
//  XYRegulationDetailController.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/4/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYRegulationDetailController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>
#import <WebKit/WKPreferences.h>

@interface XYRegulationDetailController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView * webView;

@end

@implementation XYRegulationDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    WKPreferences *preference = [[WKPreferences alloc]init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 14;
    config.preferences = preference;
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self reloadData];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self showLoadingAnimation];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self stopLoadingAnimation];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self stopLoadingAnimation];
    [self showEmpty];
}

- (void)reloadData{
    [super reloadData];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]]];
}

@end
