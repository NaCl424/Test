//
//  CityList1TableVC.m
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "CityList1TableVC.h"
#import "FoodCell.h"

@interface CityList1TableVC () 
{
    NSArray *_foods;
}
@end

@implementation CityList1TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadJsonFile];

}

- (instancetype)initWithCityIndex:(NSInteger)cityIndex cityListIndex:(NSInteger)index
{
    self = [super init];
    if (self) {

        NSMutableArray *foodArray = [[NSMutableArray alloc] init];

        NSString *fileName = [NSString stringWithFormat:@"CityList%ld%ld", (long)cityIndex, (long)index];
        NSDictionary *responseObject = [JSONDataService loadJSONFielWithName:fileName];
        NSArray *listArray = responseObject[@"data"][@"list"];
        for (NSDictionary *dic in listArray) {
            Food *food = [[Food alloc] init];
            food.name = dic[@"name"];
            food.imageName = dic[@"cover"];
            food.sum = dic[@"sum"];
            [foodArray addObject:food];
        }
        _foods = [foodArray copy];
        [self.tableView reloadData];
    }
    return self;
}
- (void)loadJsonFile {

}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _foods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FoodCell" owner:nil options:nil] lastObject];
    }
    Food *food = _foods[indexPath.row];
    cell.food = food;
    
    return cell;
}

#pragma mark - 设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 120;
}


@end
