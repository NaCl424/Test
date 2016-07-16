//
//  RestaurantCell.m
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "RestaurantCell.h"

@implementation RestaurantCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRestaurant:(Restaurant *)restaurant {

    if (_restaurant == restaurant) {
        return;
    }
    _restaurant = restaurant;
    _name.text = _restaurant.name;
    _place.text = _restaurant.label;
    _price.text = [NSString stringWithFormat:@"%@元/人", _restaurant.cost];
    _reason.text = _restaurant.summary;
    [_restaurantImageView sd_setImageWithURL:[NSURL URLWithString:_restaurant.imageName]];

}
@end
