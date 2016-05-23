//
//  MoviePostView.m
//  Movie
//
//  Created by 林林 on 16/5/17.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "MoviePostView.h"
#import "MoviePostCollectionView.h"
#import "SmallPostCollectionView.h"

@interface MoviePostView ()
{
    UIView *_headerView;
    UIView *_blackView;
    UIImageView *_leftLight;
    UIImageView *_rightLight;
    UIButton *yellowButton;
}

@end

@implementation MoviePostView

- (void)awakeFromNib {
    
    [self creatSubviews];
}

- (void)creatSubviews {
    
    //创建背景图
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -74, KScreenWidth, 100)];
    _headerView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headerView];
//    _headerView.userInteractionEnabled = YES;
    
    //添加图片背景
    UIImageView *headerBgView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    [_headerView addSubview:headerBgView];
    //拉伸图片
    UIImage *image = [UIImage imageNamed:@"indexBG_home"];
    image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:3];
    headerBgView.image = image;
    headerBgView.userInteractionEnabled = YES;
 
    //添加下拉按钮
    yellowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    yellowButton.frame = CGRectMake(0, 0, 13, 10);
    yellowButton.center = CGPointMake(KScreenWidth / 2, 90);
    [yellowButton setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [yellowButton setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];
    //添加下拉事件
    [yellowButton addTarget:self action:@selector(headerViewMoveAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerBgView addSubview:yellowButton];
    
    //添加黑色遮罩
    _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _blackView.backgroundColor = [UIColor blackColor];
    _blackView.alpha = 0.5;
    [self insertSubview:_blackView belowSubview:_headerView];
    _blackView.hidden = YES;
    
    //添加左边的灯
    _leftLight = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 90)];
    _leftLight.center = CGPointMake(KScreenWidth/2 - 70, 45);
    _leftLight.image = [UIImage imageNamed:@"light"];
    [self addSubview:_leftLight];
//    _leftLight.hidden = YES;
    _leftLight.alpha = 0;
    
    //添加右边的灯
    _rightLight = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 90)];
    _rightLight.center = CGPointMake(KScreenWidth/2 + 70, 45);
    _rightLight.image = [UIImage imageNamed:@"light"];
    [self addSubview:_rightLight];
//    _rightLight.hidden = YES;
    _rightLight.alpha = 0;
    
    //添加手势
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewMoveDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDown];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewMoveUP)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeUp];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewMoveUP)];
    [_blackView addGestureRecognizer:tap];
    
    [self creatCollectionView];
    
    [self creatTopCollectionView];
    
}



//创建ocollectionView
- (void)creatCollectionView {
    
    MoviePostCollectionView *MoviePostCollection = [[MoviePostCollectionView alloc] initWithFrame:CGRectMake(0, -44, KScreenWidth, KScreenHeight - 20 - 49 - 40)];
    [self insertSubview:MoviePostCollection atIndex:0];
    MoviePostCollection.tag = 1234;
    
    //KVO监控页码值
    [MoviePostCollection addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:nil];
    
}

//创建上面的collectionView
- (void)creatTopCollectionView {
    
    SmallPostCollectionView *SmallPostCollection = [[SmallPostCollectionView alloc] initWithFrame:CGRectMake(0, 10, KScreenWidth, 70)];
    [_headerView insertSubview:SmallPostCollection atIndex:1];
    SmallPostCollection.tag = 4321;
    
    //KVO监控页码值
    [SmallPostCollection addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSInteger itemInteger = [change[@"new"] integerValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemInteger inSection:0];
    //获取视图
    SmallPostCollectionView *header = (SmallPostCollectionView *)[_headerView viewWithTag:4321];
    MoviePostCollectionView *postCollection = (MoviePostCollectionView *)[self viewWithTag:1234];
    //通过判断对象来确定需要改变的对象
    if (object == header && postCollection.currentIndex != itemInteger) {
        [postCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }else if(object == postCollection && header.currentIndex != itemInteger){
        [header scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    
}


- (void)headerViewMoveAction:(UIButton *)button {
    
    if (button.selected) {
        [self headerViewMoveUP];
    }else {
        [self headerViewMoveDown];
    }
    
}
#pragma mark - 视图移动方法
- (void)headerViewMoveDown {
    
    [UIView animateWithDuration:0.5 animations:^{
        yellowButton.selected = YES;
        _headerView.top = -10;
        _blackView.hidden = NO;
//        _leftLight.hidden = NO;
//        _rightLight.hidden = NO;
        _leftLight.alpha = 1;
        _rightLight.alpha = 1;
    }];
}

- (void)headerViewMoveUP {
    
    [UIView animateWithDuration:0.5 animations:^{
        yellowButton.selected = NO;
        _headerView.top = -74;
        _blackView.hidden = YES;
//        _leftLight.hidden = YES;
//        _rightLight.hidden = YES;
        _leftLight.alpha = 0;
        _rightLight.alpha = 0;
    }];

}
@end












