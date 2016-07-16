//
//  CityListButton.h
//  AfterTaste
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityListButton : UIButton

@property (nonatomic, strong)UIImageView *topImageView;
@property (nonatomic, strong)UILabel *lable;

@property (nonatomic, strong)CityList *cityList;
@end
