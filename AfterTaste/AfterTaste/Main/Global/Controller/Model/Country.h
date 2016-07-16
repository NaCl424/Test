//
//  Country.h
//  AfterTaste
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 ljp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *imageName;

@property (nonatomic, strong)NSMutableArray *cities;

@property (nonatomic, assign)NSInteger index;

//加载网络请求数据
- (void)countryRequestWithContinentIndex:(NSInteger)continentIndex;
//加载本地json数据
- (void)loadJsonFileWithContinentIndex:(NSInteger)continentIndex;


@end

