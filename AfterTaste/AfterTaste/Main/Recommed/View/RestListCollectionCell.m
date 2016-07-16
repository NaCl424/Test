//
//  RestListCollectionCell.m
//  AfterTaste
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "RestListCollectionCell.h"
#import "RestaurantCell.h"
#import "Restaurant.h"
#import "RestDetailViewController.h"
@implementation RestListCollectionCell


- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UINib *cellNib = [UINib nibWithNibName:@"RestaurantCell" bundle:[NSBundle mainBundle]];
        [_tableView registerNib:cellNib forCellReuseIdentifier:@"restCell"];
        [self.contentView addSubview:_tableView];
        
    }

    return self;
}



- (void)setDataDic:(NSDictionary *)dataDic {
    
    if (_dataDic == dataDic) {
        
        return;
    }
    _dataDic = dataDic;
    NSDictionary *restListDic = dataDic[@"restlist"];
    _listArray = restListDic[@"list"];
    [_tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _listArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return kScreenWidth / 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"restCell"];
    
    Restaurant *restModel = [[Restaurant alloc] initWithJsonName:_listArray[indexPath.row]];
    cell.restaurant = restModel;

    return cell;
}


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
