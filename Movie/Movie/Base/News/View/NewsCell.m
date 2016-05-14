//
//  NewsCell.m
//  Movie
//
//  Created by 林林 on 16/5/13.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "NewsCell.h"
//#import "UIImageView+WebCache.h"

@implementation NewsCell

- (void)setNews:(News *)news {
    
    if (_news == news) {
        return;
    }
    _news = news;
    //填充数据
    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:news.image]];
    _titleLabel.text = news.title;
    if (news.type == NewsTypeNone) {
        _typeImageView.image = nil;
        _summaryLabel.text = news.summary;
    }else if (news.type == NewsTypeImage) {
        _typeImageView.image = [UIImage imageNamed:@"sctpxw"];
        _summaryLabel.text = [NSString stringWithFormat:@"     %@", news.summary];
//        _summaryLabel.transform = CGAffineTransformMakeTranslation(18, 0);
    }else {
        _typeImageView.image = [UIImage imageNamed:@"scspxw"];
        _summaryLabel.text = [NSString stringWithFormat:@"     %@", news.summary];
//        _summaryLabel.transform = CGAffineTransformMakeTranslation(18, 0);
    }
    
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
