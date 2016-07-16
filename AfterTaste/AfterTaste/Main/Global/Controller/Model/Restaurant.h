//
//  Restaurant.h
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *cost; //人均价格
@property (nonatomic, strong)NSString *imageName;
@property (nonatomic, strong)NSString *label;
@property(nonatomic, assign)CGFloat lng;
@property(nonatomic, assign)CGFloat lat;
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, copy)NSString *cover;  //图片
@property(nonatomic, copy)NSString *address;
@property(nonatomic, copy)NSString *open_time; //营业时间
@property(nonatomic, copy)NSString *type;  //类型
@property(nonatomic, copy)NSString *summary; //简介
@property(nonatomic, copy)NSString *reason; //推荐理由
@property(nonatomic, copy)NSString *desc;  //详情


- (instancetype)initWithJsonName:(NSDictionary *)dic;

@end
