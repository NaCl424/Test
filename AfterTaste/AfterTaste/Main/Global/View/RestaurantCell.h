//
//  RestaurantCell.h
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *place;
@property (strong, nonatomic) IBOutlet UILabel *reason;
@property (strong, nonatomic) IBOutlet UIImageView *restaurantImageView;

@property (nonatomic, strong)Restaurant *restaurant;

@end
