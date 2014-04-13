//
//  ViewController.m
//  NLG
//
//  Created by Sam Green on 4/13/14.
//  Copyright (c) 2014 NextLevelGeek. All rights reserved.
//

#import "ArticlesViewController.h"

@interface ArticlesViewController ()

@end

@implementation ArticlesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

@end
