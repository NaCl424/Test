//
//  TopModel.m
//  Movie
//
//  Created by 林林 on 16/5/13.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "TopModel.h"

@implementation TopModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        //填充数据
        NSDictionary *rating = dic[@"rating"];
        self.title = dic[@"title"];
        self.rating = [rating[@"average"] doubleValue];
        self.images = dic[@"images"];
    }
    
    return self;
}

@end
