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
    
    self.contentHTML = self.contentHTML;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)setContentHTML:(NSString *)contentHTML {
    _contentHTML = contentHTML;
    
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    NSString *templateHTML = [[NSString alloc] initWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:NULL];
    [self.webView loadHTMLString:[NSString stringWithFormat:templateHTML, self.contentHTML] baseURL:nil];
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
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
