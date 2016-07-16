//
//  ContinentCell.h
//  AfterTaste
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 ljp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ContinentCellCountryBlock)();
typedef void(^ContinentCellCityBlock)(NSInteger);

@interface ContinentCell : UITableViewCell

@property(nonatomic, strong)id cellObject;

@property(nonatomic, copy)ContinentCellCountryBlock countryBlock;
@property(nonatomic, copy)ContinentCellCityBlock cityBlock;

@end
