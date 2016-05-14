//
//  RatingView.m
//  Movie
//
//  Created by 林林 on 16/5/11.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "RatingView.h"
//#import "UIViewExt.h"

@interface RatingView ()
{
    UIView *_grayView;
    UIView *_yellowView;
}

@end

@implementation RatingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //创建星星视图
        [self creatViews];
//        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)creatViews {
    
    //创建图片
    UIImage *grayImage = [UIImage imageNamed:@"gray"];
    UIImage *yellowImage = [UIImage imageNamed:@"yellow"];
    
    //创建星星视图
    //创建灰色的星星
    _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
    [self addSubview:_grayView];
    //创建黄色的星星
    _yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, yellowImage.size.width *5, yellowImage.size.height)];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
    [self addSubview:_yellowView];
    
    //视图缩放到和View一样
    CGFloat xScale = self.width / _grayView.width;
    CGFloat yScale = self.height / _grayView.height;
    
    _grayView.transform = CGAffineTransformMakeScale(xScale, yScale);
    _yellowView.transform = CGAffineTransformMakeScale(xScale, yScale);
    //改变视图位置与原视图重合
    _grayView.center = CGPointMake(self.width/2, self.height/2);
    _yellowView.center = CGPointMake(self.width/2, self.height/2);
    _yellowView.left = _grayView.left;
    
}

//xib中的视图创建
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self creatViews];
}
//改变黄色的星星的视图宽度
- (void)setRating:(CGFloat)rating {
    
    _yellowView.width = rating / 10 *_grayView.width;
    
}


@end











