//
//  RecommentHeaderView.m
//  AfterTaste
//
//  Created by mac on 16/6/30.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "RecommentHeaderView.h"
#import "UIImageView+AFNetworking.h"
#import "SearchViewController.h"
#import "NearbyViewController.h"
@implementation RecommentHeaderView


- (void)awakeFromNib {

    [super awakeFromNib];
    
    //背景图片添加单击手势
    UITapGestureRecognizer *backImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundImageTapAC)];
    backImageTap.numberOfTapsRequired = 1;
    backImageTap.numberOfTouchesRequired = 1;
    _backgroundImage.userInteractionEnabled = YES;
    [_backgroundImage addGestureRecognizer:backImageTap];
    
    //搜索框添加单击手势
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchTapAC)];
    searchTap.numberOfTapsRequired = 1;
    searchTap.numberOfTouchesRequired = 1;
    _searchView.userInteractionEnabled = YES;
    [_searchView addGestureRecognizer:searchTap];
    
    _searchView.layer.borderWidth = 1;
    _searchView.layer.borderColor = [UIColor whiteColor].CGColor;
    _searchView.layer.cornerRadius = 10;
    
    //设置一层灰色效果,
    CAGradientLayer *grayLayer = [CAGradientLayer layer];
    grayLayer.colors = @[((__bridge id)[UIColor grayColor].CGColor),
                         ((__bridge id)[UIColor whiteColor].CGColor),
                         ((__bridge id)[UIColor blackColor].CGColor)];
    grayLayer.startPoint = CGPointMake(0, 0);
    grayLayer.endPoint = CGPointMake(0, 1);
    grayLayer.frame = CGRectMake(0, 0, kScreenWidth+16, kScreenWidth/1.5);
    grayLayer.opacity = 0.3;
    [_backgroundImage.layer addSublayer:grayLayer];
}


- (void)layoutSubviews {

    [super layoutSubviews];
    
    [_backgroundImage setImageWithURL:[NSURL URLWithString:@"http://cdn.youyuwei.com/o_19vvaa1repcs1di614g88cll1j9.jpg?imageView2/2/w/1080/h/930"]];

}


- (void)backgroundImageTapAC {

    NSLog(@"backgroundImageTap");


}

- (void)searchTapAC {
    
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;

    UINavigationController *naviCtl = [self navigationController];
    
    [naviCtl pushViewController:searchVC animated:YES];
    [naviCtl setNavigationBarHidden:NO animated:YES];

}

//附近按钮
- (IBAction)localButtonAction:(UIButton *)sender {
    
    NearbyViewController *nearbyVC = [[NearbyViewController alloc] init];

    NSDictionary * resDic = [JSONDataService loadJSONFielWithName:@"NearbyRestJson"];
    nearbyVC.response = resDic;
    nearbyVC.hidesBottomBarWhenPushed = YES;
    
    UINavigationController *naviCtl = [self navigationController];
    
    [naviCtl pushViewController:nearbyVC animated:YES];
    [naviCtl setNavigationBarHidden:NO animated:YES];
    
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
