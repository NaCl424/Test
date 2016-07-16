//
//  ImageViewController.m
//  滤镜
//
//  Created by 林林 on 16/7/6.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
{
    UIImageView *_imageView;
}

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI {
    
    //照片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, kScreenWidth - 20, kScreenHeight - 50 - 20 - 164)];
    _imageView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_imageView];
    _imageView.image = _photoImage;
    
    //输入框
    
    
    //subViews
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50 - 64, kScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, 5, 40, 40);
    [leftButton setImage:[UIImage imageNamed:@"topic_abandon"] forState:UIControlStateNormal];
    [bottomView addSubview:leftButton];
    
    UIButton *roghtButton = [UIButton buttonWithType:UIButtonTypeCustom];
    roghtButton.frame = CGRectMake(kScreenWidth - 10 - 40, 5, 40, 40);
    [roghtButton setImage:[UIImage imageNamed:@"finishe_publish"] forState:UIControlStateNormal];
    [bottomView addSubview:roghtButton];
    
    //backButton
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"lan_shut"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)backClick:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)setPhotoImage:(UIImage *)photoImage {
    
    if (_photoImage == photoImage) {
        return;
    }
    _photoImage = photoImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
