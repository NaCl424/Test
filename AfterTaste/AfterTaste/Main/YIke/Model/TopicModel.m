//
//  TopicModel.m
//  AfterTaste
//
//  Created by 林林 on 16/7/5.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.cover = dic[@"cover"];
        self.peoplenum = [NSString stringWithFormat:@"%@人参与", dic[@"peoplenum"]];
        self.url = dic[@"url"];
        self.label = dic[@"label"];
    }
    return self;
}

@end
