//
//  Article.h
//  NLG
//
//  Created by Sam Green on 4/13/14.
//  Copyright (c) 2014 NextLevelGeek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

+ (instancetype)articleFromDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *contentHTML;

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSString *dateString;

@end
