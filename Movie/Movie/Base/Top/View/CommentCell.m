//
//  CommentCell.m
//  Movie
//
//  Created by 林林 on 16/5/15.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)setCommentModel:(CommentModel *)commentModel {
    
    if (_commentModel == commentModel) {
        return;
    }
    _commentModel = commentModel;
    _commentBackView.layer.cornerRadius = 8.0;
    NSURL *url = [NSURL URLWithString:commentModel.userImage];
    [_userImage sd_setImageWithURL:url];
    
    _nickName.text = commentModel.nickname;
    _rating.text = commentModel.rating;
    _content.numberOfLines = 0;
    _content.text = commentModel.content;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
