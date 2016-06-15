//
//  MessageCell.h
//  WeChat
//
//  Created by JayWon on 15/10/9.
//  Copyright (c) 2015年 JayWon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

#define kEdgeSize 10        //间隙
#define kHeadImgSize 40     //头像的宽高

@interface MessageCell : UITableViewCell
{
    UIImageView *_userImg;      //用户头像
    UIImageView *_bgImg;        //背景
    UILabel     *_msgLabel;     //消息内容
}

@property(nonatomic, strong)Message *msg;

@end
