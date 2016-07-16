//
//  CityList2TableVC.m
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "CityList2TableVC.h"
#import "RestaurantCell.h"
#import "RestDetailViewController.h"

@interface CityList2TableVC ()
{
    NSMutableArray *_restaurants;
    NSArray *_listArray;;
}
@end

@implementation CityList2TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (instancetype)initWithCityIndex:(NSInteger)cityIndex cityListIndex:(NSInteger)index
{
    self = [super init];
    if (self) {

        _restaurants = [[NSMutableArray alloc] init];

        NSString *fileName = [NSString stringWithFormat:@"CityList%ld%ld", (long)cityIndex, (long)index];
        NSDictionary *responseObject = [JSONDataService loadJSONFielWithName:fileName];
        _listArray = responseObject[@"data"][@"list"];
        for (NSDictionary *dic in _listArray) {
            Restaurant *restaurant = [[Restaurant alloc] init];
            restaurant.name = dic[@"name"];
            restaurant.imageName = dic[@"cover"];
            restaurant.reason = dic[@"reason"];
            restaurant.cost = dic[@"cost"];
            restaurant.label = dic[@"label"];
            restaurant.summary = dic[@"summary"];
            [_restaurants addObject:restaurant];
        }
        [self.tableView reloadData];
    }
    return self;
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _restaurants.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {

        cell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantCell" owner:nil options:nil] lastObject];
    }
    cell.restaurant = _restaurants[indexPath.row];
    return cell;

}
#pragma mark - 代理
//设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return kScreenWidth / 3;
}
//选中单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //获取故事版
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RecommendStoryboard" bundle:[NSBundle mainBundle]];

    RestDetailViewController *restDetailVC =  [sb instantiateViewControllerWithIdentifier:@"restDetailVC"];

    Restaurant *restModel = [[Restaurant alloc] initWithJsonName:_listArray[indexPath.row]];
    restDetailVC.restModel = restModel;

    if ([self navigationController]) {

        [[self navigationController] pushViewController:restDetailVC animated:YES];
    }
}
//使用响应者链获取导航控制器
- (UINavigationController *)navigationController {

    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)nextResponder;
        }
        nextResponder = nextResponder.nextResponder;
    }

    return nil;
}
@end
