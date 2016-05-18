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







