//
//  Movie.h
//  Movie
//
//  Created by 林林 on 16/5/11.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Movie : NSObject

@property (nonatomic, copy) NSString *title; //电影名
@property (nonatomic, copy) NSString *original_title; //英文名
@property (nonatomic, assign) CGFloat rating; //电影评分
@property (nonatomic, copy) NSString *year; //上映年份
@property (nonatomic, strong) NSDictionary *images; //电影图片

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
