//
//  ArticleDetailViewController.m
//  NLG
//
//  Created by Sam Green on 4/13/14.
//  Copyright (c) 2014 NextLevelGeek. All rights reserved.
//

#import "ArticleDetailViewController.h"

@interface ArticleDetailViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64.f, 0, 0, 0);
    
    [self loadURL:self.URL];
}

- (void)setURL:(NSURL *)URL {
    _URL = URL;
    
    [self loadURL:self.URL];
}

- (void)loadURL:(NSURL *)URL {
    // Don't reload the same URL
    if ([self.webView.request.URL isEqual:URL]) return;
    
//    NSString *readableURLString = [@"http://www.readability.com/read?url=" stringByAppendingString:URL.absoluteString];
//    NSURL *readableURL = [NSURL URLWithString:readableURLString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:readableURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.URL];
    [self.webView loadRequest:request];
}

#pragma mark - Web View Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    webView.hidden = NO;
    
    NSString *titleScript = @"document.title";
    NSString *pageTitle = [webView stringByEvaluatingJavaScriptFromString:titleScript];
    self.title = pageTitle;
    
    NSString *script = @"scrollTo(0, 260);";
    [webView stringByEvaluatingJavaScriptFromString:script];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
