//
//  NLGHTTPSessionManager.h
//  NLG
//
//  Created by Sam Green on 4/13/14.
//  Copyright (c) 2014 NextLevelGeek. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NLGHTTPSessionManager : AFHTTPSessionManager

+ (void)fetchArticles:(void (^)(NSArray *articles, NSError *error))block;
+ (void)fetchNumberOfArticles:(NSUInteger)count complete:(void (^)(NSArray *articles, NSError *error))block;

@end
