//
//  Message.h
//  WeChat
//
//  Created by JayWon on 15/10/9.
//  Copyright (c) 2015年 JayWon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface Message : NSObject

@property(nonatomic, copy)NSString *content;    //内容
@property(nonatomic, copy)NSString *time;       //时间
@property(nonatomic, copy)NSString *icon;       //头像
@property(nonatomic, assign)BOOL isSelf;

//显示content的字体大小
@property(nonatomic, assign, readonly)CGFloat contentFontSize;

//根据content内容、文字大小提前计算content显示的时候需要的frame
@property(nonatomic, assign, readonly)CGRect frame;

@end
