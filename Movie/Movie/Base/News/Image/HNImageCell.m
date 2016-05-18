//
//  HNImageCell.m
//  图片浏览
//
//  Created by 林林 on 16/5/16.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "HNImageCell.h"
#import "UIImageView+WebCache.h"

@interface HNImageCell ()
{
    NSTimer *tapTimer;
}
@end

@implementation HNImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //创建子视图
        [self creatSubviews];
        
    }
    return self;
}

- (void)creatSubviews {
    //创建滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_scrollView];
    //创建图片
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [_scrollView addSubview:_imageView];
    //滑动范围
    _scrollView.contentSize = _imageView.bounds.size;
    //设置图片拉伸模式
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //缩放
    //开启多点触控
    _scrollView.multipleTouchEnabled = YES;
    //设置缩放大小
    _scrollView.maximumZoomScale = 3;
    _scrollView.minimumZoomScale = 1;
    //设置代理
    _scrollView.delegate = self;
    
    //创建单击手势识别器
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTap:)];
    //设置手势
    oneTap.numberOfTapsRequired = 1;
    oneTap.numberOfTouchesRequired = 1;
    //添加手势到视图
    [_scrollView addGestureRecognizer:oneTap];
    
    //创建双击手势识别器
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    //设置手势
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    //添加手势到视图
    [_scrollView addGestureRecognizer:doubleTap];
    //双击时不触发单击事件
//    [oneTap requireGestureRecognizerToFail:doubleTap];
    
}
#pragma mark 手势识别
- (void)oneTap:(UITapGestureRecognizer *)tap {
    //开启定时器，设定时间间隔
    tapTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(oneTapAction) userInfo:nil repeats:NO];
}

- (void)oneTapAction {
    
//    NSLog(@"单击了");
    [[NSNotificationCenter defaultCenter] postNotificationName:KHidenNotification object:nil];
}

- (void)doubleTap:(UITapGestureRecognizer *)tap {
    
    //双击事件触发，不触发单击事件
    [tapTimer invalidate];
    
    //判断缩放状态
    if (_scrollView.zoomScale > 2) {
        //还原
        [_scrollView setZoomScale:1 animated:YES];
    }else {
        //放大
        [_scrollView setZoomScale:2.5 animated:YES];
    }
}

- (void)setUrl:(NSURL *)url {
    
    if (_url != url) {
        _url = url;
        [_imageView sd_setImageWithURL:url];
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _imageView;
}
//还原大小
- (void)backToOneScale {
    
    _scrollView.zoomScale = 1;
}

@end
