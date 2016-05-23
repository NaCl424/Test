//
//  CinemaCell.m
//  Movie
//
//  Created by 林林 on 16/5/19.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "CinemaCell.h"

@implementation CinemaCell

- (void)setCinema:(Cinema *)cinema {
    
    if (_cinema == cinema) {
        return;
    }
    _cinema = cinema;
    _nameLabel.text = cinema.name;
    _addressLabel.text = cinema.address;
    _gradeLabel.text = cinema.grade;
    if ([cinema.lowPrice isKindOfClass:[NSNull class]]) {
        _lowPriceLabel.hidden = YES;
    }else {
        _lowPriceLabel.hidden = NO;
        _lowPriceLabel.text = cinema.lowPrice;
    }
    _seatImage.hidden = !cinema.isSeatSupport;
    _couponImage.hidden = !cinema.isCouponSupport;
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
