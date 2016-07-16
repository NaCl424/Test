//
//  CityListView.m
//  AfterTaste
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "CityListView.h"
#import "CityListButton.h"
#import "CityListLayout.h"

#import "CityList1TableVC.h"
#import "CityList2TableVC.h"
#import "CityList5TableVC.h"
//字体闪烁
#import "JTSlideShadowAnimation.h"

#import "NearbyViewController.h"
@interface CityListView ()

{
    CGPoint _firstPoint;
    JTSlideShadowAnimation *animation;
}
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *englishName;

@property (strong, nonatomic) IBOutlet UIImageView *cityNewImageView;
@property (strong, nonatomic) IBOutlet UILabel *cityNewLabel;

@end

@implementation CityListView

- (void)setCity:(City *)city {
    if (_city == city) {
        return;
    }
    _city = city;

    _name.text = city.name;
    _englishName.text = city.englishName;

    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    for (int i = 0; i < _city.cityLists.count; i++) {
        CityList *cityList = _city.cityLists[i];
        cityList.index = i;
        CityListButton *button = [CityListButton buttonWithType:UIButtonTypeCustom];
        button.cityList = cityList;

        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (cityList.isDisplay == YES) {
            [self addSubview:button];
            [buttons addObject:button];
        }
    }
    CityListLayout *layout = [CityListLayout layoutWithButtons:buttons];
    for (int i = 0; i < buttons.count; i++) {
        CityListButton *button = buttons[i];
        button.frame = [layout.buttonsFrames[i] CGRectValue];
    }

}
- (void)awakeFromNib {

//    _cityNewImageView.image = [UIImage imageNamed:@"city_new_1"];
    _cityNewLabel.hidden = YES;
    animation = [[JTSlideShadowAnimation alloc] init];
    animation.animatedView = _cityNewImageView;
    animation.shadowWidth = _cityNewImageView.height;
    [animation start];
}
- (void)buttonAction:(CityListButton *)button {

    if (_block) {

        _block(button.cityList);
    }
};

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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    _firstPoint = [touch locationInView:self.superview];
    _cityNewImageView.hidden = YES;
    _cityNewLabel.hidden = NO;
    [animation stop];
    animation.animatedView = _cityNewLabel;
    [animation start];

//    _cityNewImageView.image = [UIImage imageNamed:@"city_new_2"];

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {


    _cityNewImageView.hidden = NO;
    _cityNewLabel.hidden = YES;
    [animation stop];
    animation.animatedView = _cityNewImageView;
    [animation start];
//    _cityNewImageView.image = [UIImage imageNamed:@"city_new_1"];
    [UIView animateWithDuration:0.4 animations:^{

        self.top = 0;
    }];
    UITouch *touch = [touches anyObject];
    CGPoint newPoint = [touch locationInView:self.superview];


    if (_firstPoint.y - newPoint.y >= 50) {

        NearbyViewController *nearVC = [[NearbyViewController alloc] init];

        NSDictionary *responseObject = [JSONDataService loadJSONFielWithName:[NSString stringWithFormat:@"CityList%ld4", _city.index]];

        nearVC.response = [responseObject copy];
        [[self navigationController] pushViewController:nearVC animated:YES];
    }

}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint newPoint = [touch locationInView:self.superview];

    if (_firstPoint.y - newPoint.y >= 50) {
//        _cityNewImageView.image = [UIImage imageNamed:@"city_new_3"];
        _cityNewLabel.text = @"释放进入餐厅列表";
    }else if (_firstPoint.y - newPoint.y <= 50) {
//        _cityNewImageView.image = [UIImage imageNamed:@"city_new_2"];
        _cityNewLabel.text = @"上拉查看餐厅列表";

    }
    self.top = newPoint.y -  _firstPoint.y;
}

@end
