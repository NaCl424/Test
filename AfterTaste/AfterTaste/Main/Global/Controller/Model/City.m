//
//  City.m
//  AfterTaste
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 ljp. All rights reserved.
//

#import "City.h"

@implementation City

- (void)loadJsonFileWithCountryIndex:(NSInteger)countryIndex {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:
                          @"CityRequest" ofType:@"plist"];
    NSArray *jsonNames = [NSArray arrayWithContentsOfFile:filePath];
    NSString *jsonName = jsonNames[countryIndex][_index];

    NSDictionary *responseObject = [JSONDataService loadJSONFielWithName:jsonName];
    
    NSDictionary *dataDic = responseObject[@"data"];
    NSDictionary *cityinfo = dataDic[@"cityinfo"];
    _name = cityinfo[@"name"];
    _englishName = cityinfo[@"en"];
    _coverString = cityinfo[@"cover"];
    NSMutableArray *cityListArray = [[NSMutableArray alloc] init];
    NSArray *listArray = dataDic[@"list"];
    for (NSDictionary *dic in listArray) {

        CityList *cityList = [[CityList alloc] init];
        cityList.name = dic[@"title"];
        cityList.isDisplay = [dic[@"isdisplay"] boolValue];
        cityList.urlString = dic[@"url"];

        [cityListArray addObject:cityList];
        self.cityLists = [cityListArray copy];
    }

}
- (void)cityRequestWithCountryIndex:(NSInteger)countryIndex {


    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CityRequest" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];

    NSArray *countryArray = array[countryIndex];
    NSString *urlString = countryArray[_index];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableLeaves];
    [manager GET:urlString
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {

             NSDictionary *dataDic = responseObject[@"data"];
             NSDictionary *cityinfo = dataDic[@"cityinfo"];
             _englishName = cityinfo[@"en"];
             _coverString = cityinfo[@"cover"];
             NSMutableArray *cityListArray = [[NSMutableArray alloc] init];
             NSArray *listArray = dataDic[@"list"];
             for (NSDictionary *dic in listArray) {

                 CityList *cityList = [[CityList alloc] init];
                 cityList.name = dic[@"title"];
                 cityList.isDisplay = [dic[@"isdisplay"] boolValue];
                 cityList.urlString = dic[@"url"];

                 [cityListArray addObject:cityList];
                 self.cityLists = [cityListArray copy];
             }
             [[NSNotificationCenter defaultCenter] postNotificationName:kCityRequestDidFinishedNotification object:nil];
         }
         failure:nil];

}
@end
