//
//  Cinema.m
//  Movie
//
//  Created by 林林 on 16/5/19.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "Cinema.h"

@implementation Cinema

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        //填充数据
        _name = dic[@"name"];
        _address = dic[@"address"];
        _grade = dic[@"grade"];
        _lowPrice = dic[@"lowPrice"];
        _districtId = dic[@"districtId"];
        _isSeatSupport = [dic[@"isSeatSupport"] boolValue];
        _isCouponSupport = [dic[@"isCouponSupport"] boolValue];
    }
    return self;
}


@end
