//
//  CityListLayout.m
//  AfterTaste
//
//  Created by apple on 16/7/3.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "CityListLayout.h"

@implementation CityListLayout

+ (instancetype)layoutWithButtons:(NSArray *)buttons {

    CityListLayout *layout = [[CityListLayout alloc] init];
    layout.buttons = buttons;
    return layout;
}
- (void)setButtons:(NSArray *)buttons {

    if (_buttons == buttons) {

        return;
    }
    _buttons = buttons;
    NSMutableArray *array = [[NSMutableArray alloc] init];

    if (_buttons.count == 5) {
        for (int i = 0; i < _buttons.count; i++) {

            NSInteger num = i < 3 ? 3 : 2;
            NSInteger row = i / 3;
            NSInteger column = 0;
            if (i < 3) {
                column = i % 3;
            }else {
                column = (i - 3) % 2;
            }
            CGRect frame = CGRectMake(kScreenWidth / 2 - (num - 0.5) * kCityListImageViewHeight + column * 2 * kCityListImageViewHeight, kCityListTop + row * (2 *kCityListImageViewHeight + kCityListLableHeight), kCityListImageViewHeight, kCityListImageViewHeight + kCityListLableHeight);
            [array addObject:[NSValue valueWithCGRect:frame]];
        }
    }else {
        for (int i = 0; i < _buttons.count; i++) {
            NSInteger num = _buttons.count % 3 == 0 ? 3 : 2;
            NSInteger row = i / num;
            NSInteger column = i % num;
            CGRect frame = CGRectMake(kScreenWidth / 2 - (num - 0.5) * kCityListImageViewHeight + column * 2 * kCityListImageViewHeight, kCityListTop + row * (2 *kCityListImageViewHeight + kCityListLableHeight), kCityListImageViewHeight, kCityListImageViewHeight + kCityListLableHeight);
            [array addObject:[NSValue valueWithCGRect:frame]];
        }
    }
    _buttonsFrames = [array copy];
}
@end
