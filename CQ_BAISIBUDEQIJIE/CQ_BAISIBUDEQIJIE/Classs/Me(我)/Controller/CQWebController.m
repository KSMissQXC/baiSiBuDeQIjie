//
//  CQWebController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQWebController.h"
#import <NJKWebViewProgressView.h>
#import <NJKWebViewProgress.h>
@interface CQWebController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshItem;

@property (strong, nonatomic)NJKWebViewProgress *progressProxy;

@property (strong, nonatomic)NJKWebViewProgressView *progressView;







@end

@implementation CQWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _progressView.barAnimationDuration = 0.4;
    _progressView.fadeAnimationDuration = 1;
    [_progressView setProgress:0 animated:NO];
    [self.navigationController.navigationBar addSubview:_progressView];

    
}


- (IBAction)backClick:(UIBarButtonItem *)sender {
    [self.webView goBack];
}


- (IBAction)forwardClick:(id)sender {
    [self.webView goForward];
    
}


- (IBAction)refreshClick:(id)sender {
    
    [self.webView reload];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    
    [_progressView setProgress:progress animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.backItem.enabled = [webView canGoBack];
    self.forwardItem.enabled = [webView canGoForward];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    self.progressView.hidden = YES;
}


























@end
