//
//  MovieCell.m
//  Movie
//
//  Created by 林林 on 16/5/11.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+WebCache.h"
#import "RatingView.h"

@interface MovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *MovieImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet RatingView *ratingView;

@end

@implementation MovieCell

- (void)setMovie:(Movie *)movie {
    
    if (_movie == movie) {
        return;
    }
    _movie = movie;
    //填充数据
    _titleLabel.text = movie.title;
    _yearLabel.text = [NSString stringWithFormat:@"年份:%@", movie.year];
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f", movie.rating];
    //添加图片
    NSURL *url = [NSURL URLWithString:movie.images[@"medium"]];
    [_MovieImage sd_setImageWithURL:url];
    
    [_ratingView setRating:movie.rating];
}


- (void)awakeFromNib {
    [super awakeFromNib];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
