//
//  Article.m
//  NLG
//
//  Created by Sam Green on 4/13/14.
//  Copyright (c) 2014 NextLevelGeek. All rights reserved.
//

#import "Article.h"

#import "GTMNSString+HTML.h"

@implementation Article

+ (instancetype)articleFromDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        
        NSDictionary *author = dictionary[@"author"];
        self.author = author[@"first_name"];
        
        self.URL = [NSURL URLWithString:dictionary[@"url"]];
        self.contentHTML = dictionary[@"content"];
        
        self.dateString = dictionary[@"date"];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title gtm_stringByUnescapingFromHTML];
}

@end
