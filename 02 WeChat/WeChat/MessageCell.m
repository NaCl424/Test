//
//  MessageCell.m
//  WeChat
//
//  Created by JayWon on 15/10/9.
//  Copyright (c) 2015年 JayWon. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self _createViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//创建子视图
- (void)_createViews {
    
    _userImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_userImg];
    
    _bgImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_bgImg];
    
    _msgLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _msgLabel.backgroundColor = [UIColor clearColor];
    _msgLabel.textColor = [UIColor blackColor];
    _msgLabel.numberOfLines = 0;
    [self.contentView addSubview:_msgLabel];
}

- (void)setMsg:(Message *)msg {
    
    if (_msg != msg) {
        _msg = msg;
        _msgLabel.font = [UIFont systemFontOfSize:_msg.contentFontSize];
        
        [self setNeedsLayout];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    //1.填充数据（46.5x40）
    UIImage *img1 = [UIImage imageNamed:@"chatfrom_bg_normal.png"]; //绿色
    UIImage *img2 = [UIImage imageNamed:@"chatto_bg_normal.png"];   //白色 ： 自己
    
    UIImage *img = _msg.isSelf? img2 : img1;
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(30, 23, 9, 23)];
    _userImg.image = [UIImage imageNamed:self.msg.icon];
    _bgImg.image = img;
    _msgLabel.text = self.msg.content;

    //2.布局
    if (_msg.isSelf) {  //是自己
        _userImg.frame = CGRectMake(kScreenWidth-kHeadImgSize-kEdgeSize, kEdgeSize, kHeadImgSize, kHeadImgSize);
        _bgImg.frame = CGRectMake(kScreenWidth-kHeadImgSize-kEdgeSize*2-_msg.frame.size.width-35, kEdgeSize, _msg.frame.size.width+35, _msg.frame.size.height+25);
        _msgLabel.frame = CGRectMake(kScreenWidth-kHeadImgSize-kEdgeSize*2-_msg.frame.size.width-20, kEdgeSize*2, _msg.frame.size.width, _msg.frame.size.height);
    } else {
        _userImg.frame = CGRectMake(kEdgeSize, kEdgeSize, kHeadImgSize, kHeadImgSize);
        _bgImg.frame = CGRectMake(kHeadImgSize+kEdgeSize*2, kEdgeSize, _msg.frame.size.width + 35, _msg.frame.size.height+25);
        _msgLabel.frame = CGRectMake(kHeadImgSize+kEdgeSize*2+20, kEdgeSize*2, _msg.frame.size.width, _msg.frame.size.height);
    }
    
}

@end
