//
//  TopicCell.m
//  AfterTaste
//
//  Created by 林林 on 16/7/5.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "TopicCell.h"

@implementation TopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TopicModel *)model {
    
    if (_model == model) {
        return;
    }
    _model = model;
    NSString *label = model.label;
    if ([label isEqualToString:@"0"]) {
        self.detailLabel.text = model.peoplenum;
    } else {
        self.detailLabel.text = @"今日话题";
        self.detailLabel.textColor = [UIColor orangeColor];
        self.detailLabel.layer.borderWidth = 1;
        self.detailLabel.layer.borderColor = [UIColor orangeColor].CGColor;
        self.detailLabel.textAlignment = NSTextAlignmentCenter;
    }
    NSURL *url = [NSURL URLWithString:model.cover];
    [self.coverImageView sd_setImageWithURL:url];
    self.titleLabel.text = model.title;
    
}

@end
