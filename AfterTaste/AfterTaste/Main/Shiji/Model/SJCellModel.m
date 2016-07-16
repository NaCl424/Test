//
//  SJCellModel.m
//  AfterTaste
//
//  Created by 林林 on 16/6/30.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "SJCellModel.h"

@implementation SJCellModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        
        self.cover = dic[@"cover"];
        self.url = dic[@"url"];
        self.name = dic[@"name"];
        self.city = dic[@"city"];
        self.time = [dic[@"time"] integerValue];
        self.vote = [dic[@"vote"] integerValue];
        self.fav = [dic[@"fav"] integerValue];
        self.author = [Author authorWithDictionary:dic[@"author"]];
    }
    return self;
}

@end
