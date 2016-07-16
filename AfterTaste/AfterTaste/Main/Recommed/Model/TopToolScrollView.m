//
//  TopToolScrollView.m
//  AfterTaste
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "TopToolScrollView.h"

@implementation TopToolScrollView



- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles {

    CGRect newFrame = CGRectMake(frame.origin.x - 2, frame.origin.y, frame.size.width + 4, frame.size.height);
    self = [super initWithFrame:newFrame];
    if (self) {
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        
        //创建标题
        NSInteger titleNum = titles.count;
        CGFloat titleHeight = frame.size.height;
         _buttonWidth = kScreenWidth / 3;
        self.contentSize = CGSizeMake(_buttonWidth * titleNum, titleHeight);
        for (int i = 0; i < titleNum; i ++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*_buttonWidth, 0, _buttonWidth, titleHeight);
            
            NSDictionary *titleDic = titles[i];
            NSString *titleName = titleDic[@"labelname"];
            [button setTitle:titleName forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(titleButtonAC:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            
            //第一个默认选中
            if (i == 0) {
                
                button.selected = YES;
            }
            [self addSubview:button];

        }
        
    }
    return self;
}
    
    
-(void)titleButtonAC:(UIButton *)button{

    
    if (self.toolViewBolck) {
        
        
        self.selectedIndex = button.tag;
        
        self.toolViewBolck(_selectedIndex);
        
        
    }
    
}

-(void)setSelectedIndex:(NSInteger)selectedIndex {

    if (_selectedIndex == selectedIndex) {
        return;
    }
    _selectedIndex = selectedIndex;
    //所有的button设置为不选中
    for(UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *otherButton = (UIButton *)subView;
            otherButton.selected = NO;
            if (otherButton.tag == _selectedIndex) {
                otherButton.selected = YES;
            }
        }

    }
    
    //所选的button居中
    CGFloat offsetX = (_selectedIndex - 1 ) * _buttonWidth;

    if (offsetX <= 0 || offsetX >= self.contentSize.width - 2 * _buttonWidth - 0.1) {
        return;
    }
    [self setContentOffset:CGPointMake(offsetX , 0)];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end

