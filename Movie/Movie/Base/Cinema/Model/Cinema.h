//
//  Cinema.h
//  Movie
//
//  Created by 林林 on 16/5/19.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cinema : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *lowPrice;
@property (nonatomic, assign) BOOL isSeatSupport;
@property (nonatomic, assign) BOOL isCouponSupport;
@property (nonatomic, copy) NSString *districtId;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
