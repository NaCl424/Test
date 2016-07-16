//
//  TopToolScrollView.h
//  AfterTaste
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonActionBlock) (NSInteger);

@interface TopToolScrollView : UIScrollView

@property(nonatomic, copy)ButtonActionBlock toolViewBolck;

@property(nonatomic, assign)NSInteger selectedIndex;
@property(nonatomic, assign)CGFloat buttonWidth; //每个按钮的宽度

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles;


@end
