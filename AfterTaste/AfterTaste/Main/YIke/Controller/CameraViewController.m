//
//  CameraViewController.m
//  滤镜
//
//  Created by 林林 on 16/7/6.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "CameraViewController.h"
#import "ImageViewController.h"
#import "GPUImage.h"
#import "CameraManager.h"
#import "LMCameraFilters.h"

//    判断是否是iphone4
#define IS_IPHONE4 ([UIScreen mainScreen].bounds.size.height == 480)


#define iphone4_image_scale 480 / 320

#define iphone6_image_scale 500 / 375

#define upblackview_height 40.0f

#define downblackview_height 100.0f

@interface CameraViewController ()
{
    GPUImageStillCamera *videoCamera;
    UIView *selectedView;
}

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic ,strong) UIView *topView;
@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UIScrollView *scrollView;

//new
@property (nonatomic , strong) CameraManager *cameraManager;
@property (nonatomic , strong) NSArray *filters;


@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.cameraManager startCamera];
    [self customUI];
    
}

#pragma mark 滤镜组
- (NSArray *)filters {
    if (!_filters) {
        
        GPUImageFilterGroup *f1 = [LMCameraFilters normal];
        [videoCamera addTarget:f1];
        
        GPUImageFilterGroup *f2 = [LMCameraFilters contrast];
        [videoCamera addTarget:f2];
        
        GPUImageFilterGroup *f3 = [LMCameraFilters saturation];
        [videoCamera addTarget:f3];
        
        GPUImageFilterGroup *f4 = [LMCameraFilters exposure];
        [videoCamera addTarget:f4];
        
        GPUImageFilterGroup *f5 = [LMCameraFilters testGroup1];
        [videoCamera addTarget:f5];
        
        GPUImageFilterGroup *f6 = [LMCameraFilters VignetteFilter];
        [videoCamera addTarget:f6];
        
        GPUImageFilterGroup *f7 = [LMCameraFilters ToonFilter];
        [videoCamera addTarget:f7];
        
        GPUImageFilterGroup *f8 = [LMCameraFilters SketchFilter];
        [videoCamera addTarget:f8];
        
        NSArray *arr = [NSArray arrayWithObjects:f1,f2,f3,f4,f5,f6,f7,f8,nil];
        _filters = arr;
    }
    return _filters;
}

#pragma mark 摄像头管理器
- (CameraManager *)cameraManager {
    if (!_cameraManager) {
        CGRect rect;
        float width = [UIScreen mainScreen].bounds.size.width;
        
        if (IS_IPHONE4) rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, width * iphone4_image_scale);
        else  rect = CGRectMake(0, 40, width, width * iphone6_image_scale);
        
        CameraManager *cameraManager = [[CameraManager alloc] initWithFrame:rect superview:self.view];
        [cameraManager addFilters:self.filters];
        [cameraManager setfocusImage:[UIImage imageNamed:@"touch_focus_x"]];
        _cameraManager = cameraManager;
    }
    return _cameraManager;
}

#pragma mark - customUI
- (void)customUI {
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setImage:[UIImage imageNamed:@"lan_shut"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = item;
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 80 - 64, kScreenWidth, 80)];
    _bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_bottomView];
    
    _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _photoButton.frame = CGRectMake(_bottomView.frame.size.width / 2 - 30, _bottomView.frame.size.height / 2 - 30, 60, 60);
    [_photoButton setImage:[UIImage imageNamed:@"icon_tackpic"] forState:UIControlStateNormal];
    [_photoButton addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_photoButton];
    
    //创建滤镜选择视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 80 - 60 - 64, kScreenWidth, 60)];
    _scrollView.backgroundColor = [UIColor darkGrayColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(5 + 8 * (60 + 5), 60);
    for (int i = 0; i < 8; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5 + i * (60 + 5) , 5, 50, 50);
        NSString *imageName = [NSString stringWithFormat:@"icon_filter_%i.jpg", i];
        button.tag = i;
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeFilterClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
    [self.view addSubview:_scrollView];
    
    //选中视图
    selectedView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    selectedView.backgroundColor = [UIColor clearColor];
    selectedView.layer.borderWidth = 2;
    selectedView.layer.borderColor = [UIColor orangeColor].CGColor;
    [_scrollView addSubview:selectedView];
    
}

- (void)backButton:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - 截取图片
- (void)shutterCamera {

    [self.cameraManager snapshotSuccess:^(UIImage *image) {
        
        NSLog(@"%@",image);
        ImageViewController *imageVC = [[ImageViewController alloc] init];
        imageVC.photoImage = image;
        [self.navigationController pushViewController:imageVC animated:YES];
        
    } snapshotFailure:^{
        NSLog(@"拍照失败");
    }];

}

#pragma mark - 滤镜切换
- (void)changeFilterClick:(UIButton *)button {
    
    NSInteger index = button.tag;
    [self.cameraManager setFilterAtIndex:index];
    [UIView animateWithDuration:0.3 animations:^{
        selectedView.center = button.center;
    }];
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
