//
//  SJCell.m
//  AfterTaste
//
//  Created by 林林 on 16/6/30.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "SJCell.h"
#import "UIImageView+WebCache.h"

@implementation SJCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.userIcon.layer.cornerRadius = 15;
    self.userIcon.layer.masksToBounds = YES;
    self.userIcon.layer.borderWidth = 1;
    self.userIcon.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}

- (void)setSjCellModel:(SJCellModel *)sjCellModel {
    
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:sjCellModel.cover]];
    NSString *iconStr = sjCellModel.author.header;
    self.nameLabel.text = sjCellModel.name;
//    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:iconStr]];
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:iconStr] placeholderImage:[UIImage imageNamed:@"icon_58"]];
    if (sjCellModel.city.length != 0) {
        self.cityLabel.text = sjCellModel.city;
        self.cityLabel.hidden = NO;
        self.cityIcon.hidden = NO;
    } else {
        self.cityLabel.hidden = YES;
        self.cityIcon.hidden = YES;
    }
    self.unameLabel.text = sjCellModel.author.uname;
    self.unameLabel.left = self.userIcon.right +10;
    self.userIcon.bottom = self.userIcon.bottom;
    
    self.voteLabel.text = [NSString stringWithFormat:@"%li", sjCellModel.vote];
    self.favLabel.text = [NSString stringWithFormat:@"%li", sjCellModel.fav];
    self.levelLabel.text = sjCellModel.author.level;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    
}

@end
