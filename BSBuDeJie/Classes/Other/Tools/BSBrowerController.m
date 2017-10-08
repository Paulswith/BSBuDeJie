//
//  BSBrowerController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/8.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSBrowerController.h"
#import <WebKit/WebKit.h>

@interface BSBrowerController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (strong, nonatomic) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *webContentView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *forwordBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;

@end


static NSString * const canGoBack = @"canGoBack";
static NSString * const canGoForward = @"canGoForward";
static NSString * const estimatedProgress = @"estimatedProgress";
static NSString * const title = @"title";//URL
static NSString * const URL = @"URL";
@implementation BSBrowerController
- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载逻辑
    _webView = [[WKWebView alloc] init];
    [_webContentView addSubview:_webView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
    //监听
    [self addObserver];
}
#pragma mark - observer
- (void)addObserver {
    [_webView addObserver:self forKeyPath:canGoBack options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:canGoForward options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:estimatedProgress options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:title options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:URL options:NSKeyValueObservingOptionNew context:nil];
}
//建立监听后,有变更值的时候调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    _backBtn.enabled = _webView.canGoBack;
    _forwordBtn.enabled = _webView.canGoForward;
    self.title = _webView.title;
    _progress.progress = _webView.estimatedProgress;
    _progress.hidden = (_webView.estimatedProgress == 1); // 加载完成就隐藏
    BSLog(@"webload(title:%@) | (url:%@)",_webView.title,_webView.URL);
    
}
- (void)dealloc {
    [_webView removeObserver:self forKeyPath:canGoBack];
    [_webView removeObserver:self forKeyPath:canGoForward];
    [_webView removeObserver:self forKeyPath:estimatedProgress];
    [_webView removeObserver:self forKeyPath:title];
    [_webView removeObserver:self forKeyPath:URL];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _webView.frame = _webContentView.bounds;
}

#pragma mark - btnAction
- (IBAction)goBack:(UIButton *)sender {
    [_webView goBack];
}
- (IBAction)goForward:(UIButton *)sender {
    [_webView goForward];
}
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [_webView reload];
}


@end
