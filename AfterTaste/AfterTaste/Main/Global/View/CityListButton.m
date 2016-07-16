//
//  CityListButton.m
//  AfterTaste
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "CityListButton.h"
#import "CityListLayout.h"

@interface CityListButton ()
{

}
@end

@implementation CityListButton


- (UIImageView *)topImageView {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kCityListImageViewHeight, kCityListImageViewHeight)];
    [self addSubview:imageView];

    return imageView;
}
- (UILabel *)lable {

    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kCityListImageViewHeight, kCityListLableHeight)];
    lable.top = self.topImageView.bottom;
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont boldSystemFontOfSize:12];
    lable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lable];

    return lable;
}
- (void)setCityList:(CityList *)cityList {

    if (_cityList == cityList) {
        return;
    }
    _cityList = cityList;
    NSString *imageString = [NSString stringWithFormat:@"city_new_item%ld.png", _cityList.index + 1];
    self.topImageView.image = [UIImage imageNamed:imageString];
    self.lable.text = _cityList.name;
}

@end
