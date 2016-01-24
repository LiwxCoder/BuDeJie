//
//  WXWebViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/23.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXWebViewController.h"
#import <WebKit/WebKit.h>

@interface WXWebViewController ()

/** WKWebView */
@property (nonatomic, weak) WKWebView *wkWebView;
/** 占位视图view */
@property (weak, nonatomic) IBOutlet UIView *htmlView;
/** 进度条 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 返回 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
/** 前进 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation WXWebViewController

// ----------------------------------------------------------------------------
// TODO: 使用WKWebView需先导入库WebKit库,否则会报错
/** 
 Undefined symbols for architecture x86_64:
 "_OBJC_CLASS_$_WKWebView", referenced from:
 */

#pragma =======================================================================
#pragma mark - 初始化设置

// ----------------------------------------------------------------------------
// 控制器的view加载完成调用
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加WXWebView到控制器的view,并加载网页
    [self setupWKWebView];
    
    // 2.使用KVO添加监听后退,前进,进度条,网页标题的改变
    [self setupAddObserver];
}

// ----------------------------------------------------------------------------
// 添加WXWebView到控制器的view,并加载网页
- (void)setupWKWebView
{
    // 1.添加WXWebView到控制器的view
    WKWebView *wkWebView = [[WKWebView alloc] init];
    self.wkWebView = wkWebView;
    [self.htmlView addSubview:wkWebView];
    
    // 2.通过传递的参数加载网页
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [wkWebView loadRequest:request];
}

// ----------------------------------------------------------------------------
// 控制器的view子控件布局完成调用
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // 1.设置wkWebView位置尺寸
    self.wkWebView.frame = self.htmlView.bounds;
}


#pragma =======================================================================
#pragma mark - 监听后退,前进,进度条,网页标题的监听

// ----------------------------------------------------------------------------
// 使用KVO添加监听
- (void)setupAddObserver
{
    // 1.添加后退,前进,进度条,网页标题的监听
    [self.wkWebView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkWebView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

// ----------------------------------------------------------------------------
// 观察的属性有新值的时候就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 1.更新后退,前进,进度条,网页标题的监听
    self.backItem.enabled = _wkWebView.canGoBack;
    self.forwardItem.enabled = _wkWebView.canGoForward;
    self.progressView.progress = _wkWebView.estimatedProgress;
    self.progressView.hidden = _wkWebView.estimatedProgress >= 1;
    self.title = _wkWebView.title;
}

// ----------------------------------------------------------------------------
// 移除KVO监听, 如果没移除KVO监听,点击返回会报错"NSKeyValueObservationInfo"
- (void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"canGoBack"];
    [self.wkWebView removeObserver:self forKeyPath:@"canGoForward"];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
}

#pragma =======================================================================
#pragma mark - 监听后退,前进,刷新按钮的点击调用方法

// ----------------------------------------------------------------------------
// 后退按钮点击调用
- (IBAction)back:(UIBarButtonItem *)sender {
    [self.wkWebView goBack];
}

// ----------------------------------------------------------------------------
// 前进按钮点击调用
- (IBAction)forward:(UIBarButtonItem *)sender {
    [self.wkWebView goForward];
}

// ----------------------------------------------------------------------------
// 刷新按钮点击调用
- (IBAction)reload:(UIBarButtonItem *)sender {
    [self.wkWebView reload];
}



@end
