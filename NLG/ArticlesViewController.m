//
//  ViewController.m
//  NLG
//
//  Created by Sam Green on 4/13/14.
//  Copyright (c) 2014 NextLevelGeek. All rights reserved.
//

#import "ArticlesViewController.h"
#import "ArticleDetailViewController.h"

#import "Article.h"

#import "NLGHTTPSessionManager.h"

#import "GTMNSString+HTML.h"

@interface ArticlesViewController ()

@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, strong) NSDictionary *titleAttributes;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ArticlesViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        if (self.titleAttributes == nil) {
            self.titleAttributes = @{ NSFontAttributeName: [UIFont fontWithName:@"Baskerville-Bold" size:18.f] };
        }
        
        self.title = @" ";
        
        [self fetchArticles:3];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchArticles:20];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(64.f, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    self.articles = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:animated];
}

- (IBAction)fetchArticles {
    [self fetchArticles:20];
}

- (IBAction)fetchArticles:(NSUInteger)number {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [NLGHTTPSessionManager fetchNumberOfArticles:number complete:^(NSArray *articles, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.tableView.hidden = NO;
        
        if (error == nil) {
            self.articles = articles;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Storyboard
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"pushWebView"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Article *article = [self articleForIndexPath:indexPath];
        
        ArticleDetailViewController *detailVC = (ArticleDetailViewController *)segue.destinationViewController;
        detailVC.contentHTML = article.contentHTML;
    }
}

#pragma mark - TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    
    Article *article = [self articleForIndexPath:indexPath];
    
    cell.textLabel.text = article.title;
    cell.detailTextLabel.text = article.author;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Article *article = [self articleForIndexPath:indexPath];
    
    CGSize titleSize = [article.title sizeWithAttributes:self.titleAttributes];
    CGFloat titleHeight = titleSize.height;
    CGFloat titleWidth = titleSize.width;
    
    while (titleWidth > 320.f) {
        titleWidth -= 320.f;
        titleHeight += titleSize.height;
    }
    
    
    static const CGFloat kMinimumCellHeight = 64.f;
    return kMinimumCellHeight + titleHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.articles count];
}

- (Article *)articleForIndexPath:(NSIndexPath *)indexPath {
    return self.articles[indexPath.row];
}

@end
