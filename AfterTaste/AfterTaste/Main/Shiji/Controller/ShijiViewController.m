//
//  ShijiViewController.m
//  AfterTaste
//
//  Created by 林林 on 16/6/29.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "ShijiViewController.h"
#import "ShijiContentViewController.h"
#import "ZCImagePickerController.h"
#import "IsssueViewController.h"

@class AFHTTPSessionManager;
@interface ShijiViewController () <UIScrollViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, ZCImagePickerDelegate>
{
    UIView *_selectedView;
    UIWindow *_addWindow;
    UIButton *_addButton;
}
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation ShijiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_op"]];
    self.navigationItem.titleView = titleView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建子视图
    [self createSubViews];
    //设置子控制器
    [self setupChildVC];
    //设置标签栏
    [self setupTitleLabel];
    //默认显示第0个视图控制器
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAddButtonAlpha:) name:kScrollContentOffsetNotification object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听通知
- (void)changeAddButtonAlpha:(NSNotification *)notification {
    
    CGPoint offset = [notification.userInfo[@"OffsetY"] CGPointValue];
    if (offset.y > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            _addButton.alpha = 0;
        }];
    } else if (offset.y <= 0) {
        [UIView animateWithDuration:0.3 animations:^{
            _addButton.alpha = 1;
        }];
    }
    
}

#pragma mark - 添加悬浮按钮
- (void)viewWillAppear:(BOOL)animated {
    
    //创建按钮
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(0, 0, 66, 66);
    [_addButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_addButton setImage:[UIImage imageNamed:@"topicContent_add"] forState:UIControlStateNormal];
    
    //创建UIWindow
    _addWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
    _addWindow.center = CGPointMake(kScreenWidth / 2, kScreenHeight - (49 + 20 + 33));
    _addWindow.windowLevel = UIWindowLevelAlert + 1;
    [_addWindow addSubview:_addButton];
    [_addWindow makeKeyAndVisible];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (_addWindow == nil) {
        return;
    }
    [_addWindow resignKeyWindow];
    _addWindow = nil;
    
}

#pragma mark - 悬浮按钮点击事件
- (void)clickButtonAction:(UIButton *)button {
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"imageType = %ld AND pixelWidth >= 0", 0];
    ZCImagePickerController *imagePicker = [[ZCImagePickerController alloc] initWithPredicate:pre singleSelect:NO];
    imagePicker.pickerDelegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
}

#pragma mark - ZCImagePickerDelegate
- (void)zc_ImagePickerDidFinishPickingImage:(NSArray *)images {
    
    NSLog(@"images : %@", images);
    IsssueViewController *issueVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IssueView"];
    issueVC.imageArr = [images copy];
    issueVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:issueVC animated:YES];
}


#pragma mark - SubViews
- (void)createSubViews {
    
    //标签视图
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    _titleView.backgroundColor = [UIColor whiteColor];
    _titleView.layer.borderWidth = 1;
    _titleView.layer.borderColor = [UIColor colorWithRed:195/255.0 green:195/255.0  blue:195/255.0  alpha:1].CGColor;
    [self.view addSubview:_titleView];
    //内容视图
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, kScreenWidth, kScreenHeight - 49 - 35)];
    _contentScrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight - 49 - 35);
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    [self.view addSubview:_contentScrollView];
}

#pragma mark - Setup ChildVC
- (void)setupChildVC {
    
    ShijiContentViewController *hostList = [[ShijiContentViewController alloc] init];
    [self addChildViewController:hostList];
    
    ShijiContentViewController *newList = [[ShijiContentViewController alloc] init];
    [self addChildViewController:newList];
    
}

#pragma mark - Setup Title
- (void)setupTitleLabel {
    
    CGFloat labelViewHeight = _titleView.bounds.size.height;
    UIView *labelViewLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 2, labelViewHeight)];
    labelViewLeft.tag = 0;
    [labelViewLeft addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClickAction:)]];
    [_titleView addSubview:labelViewLeft];
    UIView *labelViewRight = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 2, 0, kScreenWidth / 2, labelViewHeight)];
    labelViewRight.tag = 1;
    [labelViewRight addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClickAction:)]];
    [_titleView addSubview:labelViewRight];
    
    //选中图片
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 35 - 1, kScreenWidth / 2, 3)];
    _selectedView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_selectedView];
    
    //创建图片和文字
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 10, 22, 22)];
    leftImageView.image = [UIImage imageNamed:@"daily_hot"];
    [labelViewLeft addSubview:leftImageView];
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 10, 22, 22)];
    rightImageView.image = [UIImage imageNamed:@"daily_new"];
    [labelViewRight addSubview:rightImageView];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(50 + 22, 0, 100, 40)];
    leftLabel.text = @"最热";
    [labelViewLeft addSubview:leftLabel];
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(50 + 22, 0, 100, 40)];
    rightLabel.text = @"最新";
    [labelViewRight addSubview:rightLabel];

    
}

#pragma mark - title click action
- (void)titleClickAction:(UITapGestureRecognizer *)tap {
    
    //获取点击的下标
    NSInteger index = tap.view.tag;
    //移动选中图片
    CGRect frame = _selectedView.frame;
    frame.origin.x = (kScreenWidth / 2) * index;
    [UIView animateWithDuration:0.3 animations:^{
        _selectedView.frame = frame;
    }];
    
    //让底部内容滚动到相应位置
    CGPoint offSet = self.contentScrollView.contentOffset;
    offSet.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offSet animated:YES];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    //临时变量
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //当前位置的索引
    NSInteger index = offsetX / width;
    
    //取出需要显示的控制器
    ShijiContentViewController *willShowVC = self.childViewControllers[index];
    
    //如果显示过了就返回
    if ([willShowVC isViewLoaded]) {
        return;
    }
    
    //控制器的视图显示
    willShowVC.view.frame = CGRectMake(offsetX, 0, width, height);
    [willShowVC setRequsetType:index];
    [scrollView addSubview:willShowVC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //当前位置的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    //移动选中图片
    CGRect frame = _selectedView.frame;
    frame.origin.x = (kScreenWidth / 2) * index;
    [UIView animateWithDuration:0.3 animations:^{
        _selectedView.frame = frame;
    }];
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end








