//
//  SmallPostCell.m
//  Movie
//
//  Created by 林林 on 16/5/18.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "SmallPostCell.h"

@implementation SmallPostCell

- (void)setMovie:(Movie *)movie {
    
    if (_movie == movie) {
        return;
    }
    _movie = movie;
    [_smallPostImage sd_setImageWithURL:[NSURL URLWithString:movie.images[@"small"]]];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
