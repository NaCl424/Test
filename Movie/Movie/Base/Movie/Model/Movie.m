//
//  Movie.m
//  Movie
//
//  Created by 林林 on 16/5/11.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        //从字典取数据
        NSDictionary *subject = dic[@"subject"];
        NSDictionary *rating = subject[@"rating"];
        self.rating = [rating[@"average"] doubleValue];
        
        self.title = subject[@"title"];
        self.original_title = subject[@"original_title"];
        self.year = subject[@"year"];
        self.images = subject[@"images"];
        
    }
    return self;
}
@end
