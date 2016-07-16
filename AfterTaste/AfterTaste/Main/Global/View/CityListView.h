//
//  CityListView.h
//  AfterTaste
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CityListButtonBlock)(CityList *);

@interface CityListView : UIView

@property (nonatomic, strong)City *city;

@property (nonatomic, copy)CityListButtonBlock block;

@end
