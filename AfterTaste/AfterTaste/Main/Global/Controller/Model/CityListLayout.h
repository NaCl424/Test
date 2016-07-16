//
//  CityListLayout.h
//  AfterTaste
//
//  Created by apple on 16/7/3.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCityListImageViewHeight 50

#define kCityListTop 20 + 50 * 2
#define kCityListLableHeight 20

@interface CityListLayout : NSObject

@property (nonatomic, strong)NSArray *buttons;
@property (nonatomic, strong)NSArray *buttonsFrames;

+ (instancetype)layoutWithButtons:(NSArray *)buttons;
@end
