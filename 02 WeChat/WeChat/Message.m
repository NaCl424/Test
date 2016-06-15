//
//  Message.m
//  WeChat
//
//  Created by JayWon on 15/10/9.
//  Copyright (c) 2015年 JayWon. All rights reserved.
//

#import "Message.h"

@implementation Message

-(instancetype)init
{
    self = [super init];
    if (self) {
        _contentFontSize = 16;
    }
    return self;
}

-(void)setContent:(NSString *)content
{
    if (![content isEqualToString:_content]) {
        _content = content;

        NSDictionary *arrtDic = @{NSFontAttributeName : [UIFont systemFontOfSize:_contentFontSize]};
        CGRect frame = [content
                        boundingRectWithSize:CGSizeMake(kScreenWidth-160, 1000)
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:arrtDic
                        context:nil];
        
        _frame = frame;
    }
}

@end
