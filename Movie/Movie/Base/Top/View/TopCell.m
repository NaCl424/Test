//
//  TopCell.m
//  Movie
//
//  Created by 林林 on 16/5/13.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "TopCell.h"
#import "UIImageView+WebCache.h"

@implementation TopCell


- (void)setTopModel:(TopModel *)topModel {
    
    if (_topModel == topModel) {
        return;
    }
    _topModel = topModel;
    
    self.title.text = topModel.title;
    self.rating.text = [NSString stringWithFormat:@" %.1f", topModel.rating];
    NSURL *url = [NSURL URLWithString:topModel.images[@"medium"]];
    [self.topImageView sd_setImageWithURL:url];
    [self.ratingView setRating:topModel.rating];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
