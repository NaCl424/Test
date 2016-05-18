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
    _postDetail.hidden = YES;
}


- (void)awakeFromNib {
    [super awakeFromNib];

   
}


@end
