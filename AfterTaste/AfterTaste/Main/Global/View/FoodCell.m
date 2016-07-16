//
//  FoodCell.m
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "FoodCell.h"

@implementation FoodCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFood:(Food *)food {
    if (_food == food) {
        return;
    }
    _food = food;
    [_foodImageView sd_setImageWithURL:[NSURL URLWithString:_food.imageName]];
    _name.text = _food.name;
    _sum.text = _food.sum;


}










@end
