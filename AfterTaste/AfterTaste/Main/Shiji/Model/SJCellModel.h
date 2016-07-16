//
//  SJCellModel.h
//  AfterTaste
//
//  Created by 林林 on 16/6/30.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"

@interface SJCellModel : NSObject

@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger vote;
@property (nonatomic, assign) NSInteger fav;
@property (nonatomic, strong) Author *author;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
