//
//  CityViewController.m
//  AfterTaste
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "CityViewController.h"
#import "CityListView.h"

#import "CityList1TableVC.h"
#import "CityList2TableVC.h"
#import "NearbyViewController.h"
#import "CityList5TableVC.h"

@interface CityViewController ()

@end

@implementation CityViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    titleView.image = [UIImage imageNamed:@"icon_58"];
    self.navigationItem.titleView = titleView;

    //添加底部图片
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_city.coverString]];
    [self.view insertSubview:backgroundImageView atIndex:0];
    //添加半透明黑色视图
    UIView *blackView = [[UIView alloc] initWithFrame:self.view.bounds];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.5;

    [self.view addSubview:blackView];
    [self createSubviews];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityRequestDidFinishedAction) name:kCityRequestDidFinishedNotification object:nil];
}

- (void)cityRequestDidFinishedAction {

    CityListView *listView = [[[NSBundle mainBundle] loadNibNamed:@"CityListView" owner:nil options:nil] lastObject];
    listView.frame = self.view.bounds;
    listView.city = _city;
    listView.backgroundColor = [UIColor clearColor];

    [self.view addSubview:listView];

    listView.block = ^(CityList *cityList){

        if (cityList.index == 0) {

            BaseBackViewController *vc = [[BaseBackViewController alloc] init];
            vc.title = cityList.name;
            UIWebView *webView = [[UIWebView alloc] initWithFrame:vc.view.bounds];
            [vc.view addSubview:webView];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:cityList.urlString]];
            [webView loadRequest:request];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (cityList.index == 1) {

            CityList1TableVC *vc = [[CityList1TableVC alloc] initWithCityIndex:_city.index cityListIndex:cityList.index];
            vc.title = cityList.name;

            [self.navigationController pushViewController:vc animated:YES];
        }else if (cityList.index == 2){
            CityList2TableVC *vc = [[CityList2TableVC alloc] initWithCityIndex:_city.index cityListIndex:cityList.index];
            vc.title = cityList.name;

            [self.navigationController pushViewController:vc animated:YES];
        }else if (cityList.index == 4){
            
            NearbyViewController *nearVC = [[NearbyViewController alloc] init];
            
            NSDictionary *responseObject = [JSONDataService loadJSONFielWithName:[NSString stringWithFormat:@"CityList%ld4", _city.index]];
            
            nearVC.response = [responseObject copy];
            [self.navigationController pushViewController:nearVC animated:YES];
        }else if (cityList.index == 5){
            CityList5TableVC *vc = [[CityList5TableVC alloc] initWithCityIndex:_city.index cityListIndex:cityList.index];
            vc.title = cityList.name;

            [self.navigationController pushViewController:vc animated:YES];
        }
    };


}
- (void)createSubviews {

    [self cityRequestDidFinishedAction];
}

#pragma mark - 覆写set方法
- (void)setCity:(City *)city {

    if (_city == city) {
        return;
    }
    _city = city;
}
//#pragma mark - 创建返回按钮
//- (void)creatLeftBarButtonItem {
//
//    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    itemButton.frame = CGRectMake(20, 20, 44, 44);
//
//    [itemButton setImage:[UIImage imageNamed:@"top_back_1.png"] forState:UIControlStateNormal];
//    [itemButton addTarget:self action:@selector(itemButtonAction) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view insertSubview:itemButton aboveSubview:listView];
//}
//- (void)itemButtonAction {
//
//    [self.navigationController popViewControllerAnimated:YES];
//}
@end
