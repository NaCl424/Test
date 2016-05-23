//
//  CinemaCell.h
//  Movie
//
//  Created by 林林 on 16/5/19.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"

@interface CinemaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *seatImage;
@property (weak, nonatomic) IBOutlet UIImageView *couponImage;
@property (strong, nonatomic) Cinema *cinema;

@end
