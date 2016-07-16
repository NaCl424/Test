//
//  Country.m
//  AfterTaste
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 ljp. All rights reserved.
//


#import "Country.h"

@implementation Country

#pragma mark - 请求城市数据

- (void)loadJsonFileWithContinentIndex:(NSInteger)continentIndex {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:
    @"CountryRequest" ofType:@"plist"];
    NSArray *jsonNames = [NSArray arrayWithContentsOfFile:filePath];
    NSString *jsonName = jsonNames[continentIndex][_index];

    NSDictionary *responseObject = [JSONDataService loadJSONFielWithName:jsonName];
    NSArray *array = responseObject[@"data"][@"list"];
    _cities = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array) {
        City *city = [[City alloc] init];
        city.name = dic[@"name"];
        city.imageName = dic[@"cover"];
        [_cities addObject:city];
    }
}
- (void)countryRequestWithContinentIndex:(NSInteger)continentIndex {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CountryRequest" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSArray *continentArray = array[continentIndex];
    NSString *urlString = continentArray[_index];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableLeaves];

    [manager GET:urlString
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {

             NSArray *array = responseObject[@"data"][@"list"];
             _cities = [[NSMutableArray alloc] init];
             for (NSDictionary *dic in array) {
                 City *city = [[City alloc] init];
                 city.name = dic[@"name"];
                 city.imageName = dic[@"cover"];
                 [_cities addObject:city];
             }
             [[NSNotificationCenter defaultCenter] postNotificationName:kReloadCollectionViewNotification object:nil];
         }
         failure:nil];
}

@end
