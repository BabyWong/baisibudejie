//
//  WMWebViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/17.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMWebViewController.h"

@interface WMWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForward;

@end

@implementation WMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    
}

- (IBAction)back:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

#pragma mark -- delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    self.back.enabled = self.webView.canGoBack;
    self.goForward.enabled = self.webView.canGoForward;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
