//
//  City.h
//  AfterTaste
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 ljp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *englishName;
@property (nonatomic, copy)NSString *imageName;

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)NSArray *cityLists;
@property (nonatomic, strong)NSString *coverString;


//加载网络请求数据
- (void)cityRequestWithCountryIndex:(NSInteger)countryIndex;
//加载本地json数据
- (void)loadJsonFileWithCountryIndex:(NSInteger)countryIndex;

@end
