//
//  MoviePostCollectionCell.m
//  Movie
//
//  Created by 林林 on 16/5/17.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "MoviePostCollectionCell.h"

@implementation MoviePostCollectionCell


- (void)setMovie:(Movie *)movie {
    
    if (_movie == movie) {
        return;
    }
    _movie = movie;
    [_moviePostImage sd_setImageWithURL:[NSURL URLWithString:movie.images[@"large"]]];
    
    [_detailImage sd_setImageWithURL:[NSURL URLWithString:movie.images[@"medium"]]];
    _titleLabel.text = [NSString stringWithFormat:@"中文名:%@", movie.title];
    _englishLabel.text = [NSString stringWithFormat:@"英文名:%@", movie.original_title];
    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@", movie.year];
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f", movie.rating];
    [_ratingImage setRating:movie.rating];

}

- (void)flipView {
    
    [UIView transitionWithView:self
                      duration:0.4
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        
                        [self.contentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
                    }
                    completion:nil];
    
    
}

- (void)restore {
    
    NSArray *subViews = [self.contentView subviews];
    if ([[subViews firstObject] isKindOfClass:[UIImageView class]]) {
        
        [self.contentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];

}


@end







