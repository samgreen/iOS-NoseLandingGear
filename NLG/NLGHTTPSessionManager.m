//
//  NLGHTTPSessionManager.m
//  NLG
//
//  Created by Sam Green on 4/13/14.
//  Copyright (c) 2014 NextLevelGeek. All rights reserved.
//

#import "NLGHTTPSessionManager.h"

@implementation NLGHTTPSessionManager

+ (instancetype)manager {
    static NLGHTTPSessionManager *gManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://nextlevelgeek.com/"];
        gManager = [[NLGHTTPSessionManager alloc] initWithBaseURL:baseURL];
    });
    return gManager;
}

+ (void)fetchArticles:(void (^)(NSArray *articles, NSError *error))block {
    [self fetchNumberOfArticles:10 complete:block];
}

+ (void)fetchNumberOfArticles:(NSUInteger)count complete:(void (^)(NSArray *articles, NSError *error))block {
    NSDictionary *params = @{ @"json": @(1), @"count": @(count) };
    
    [[self manager] GET:@"/NLG/" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        block(responseObject[@"posts"], nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
    }];
}

@end
