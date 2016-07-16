//
//  Restaurant.m
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

- (instancetype)initWithJsonName:(NSDictionary *)dic {

    self = [super init];
    if (self) {

        self.name = dic[@"name"];
        self.imageName = dic[@"cover"];
        self.reason = dic[@"reason"];
        self.cost = dic[@"cost"];
        self.label = dic[@"label"];
        self.lng = [dic[@"lng"] floatValue];
        self.lat = [dic[@"lat"] floatValue];
        self.phone = dic[@"phone"];
        self.cover = dic[@"cover"];
        self.address = dic[@"address"];
        self.open_time = dic[@"open_time"];
        self.type = dic[@"type"];
        self.summary = dic[@"summary"];
        self.reason = dic[@"reason"];
        self.desc = dic[@"desc"];

    }
    return self;
}
@end
