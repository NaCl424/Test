//
//  News.m
//  Movie
//
//  Created by 林林 on 16/5/13.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "News.h"

@implementation News

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        //从字典取数据
        self.title = dic[@"title"];
        self.summary = dic[@"summary"];
        self.image = dic[@"image"];
        self.type = [dic[@"type"] intValue];
    }
    
    return self;
}

@end
