//
//  TopicModel.h
//  AfterTaste
//
//  Created by 林林 on 16/7/5.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject

@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *peoplenum;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *label;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
