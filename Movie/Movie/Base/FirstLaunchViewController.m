//
//  FirstLaunchViewController.m
//  Movie
//
//  Created by 林林 on 16/5/20.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "FirstLaunchViewController.h"
#import "MainTabBarController.h"

@interface FirstLaunchViewController () <UIScrollViewDelegate>
{
    UIImageView *pageImageView;
    UIButton *enterButton;
}

@end

@implementation FirstLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatSubviews];
}

- (void)creatSubviews {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(KScreenWidth * 5, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    
    for (int i = 1; i <= 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth *(i - 1), 0, KScreenWidth, KScreenHeight)];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d", i]];
        imageView.image = image;
        [scrollView addSubview:imageView];
    }
    [self.view addSubview:scrollView];
    
    pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth - 86.5) / 2, KScreenHeight - 50, 86.5, 13)];
    [self.view addSubview:pageImageView];
    pageImageView.image = [UIImage imageNamed:@"guideProgress1"];
    
    //添加进入主界面的button
    enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enterButton.frame = CGRectMake((KScreenWidth - 100) / 2, KScreenHeight - 100, 100, 50);
    [enterButton setTitle:@"进入程序" forState:UIControlStateNormal];
    UIColor *color = [UIColor colorWithRed:163/255.0 green:73/255.0 blue:75/255.0 alpha:1];
    [enterButton setTitleColor:color forState:UIControlStateNormal];
    enterButton.hidden = YES;
    [self.view addSubview:enterButton];
    [enterButton addTarget:self action:@selector(jumpToMainViewController) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat xOffset = scrollView.contentOffset.x + 0.5 *KScreenWidth;
    NSInteger index = xOffset / KScreenWidth;
    pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guideProgress%ld", index+1]];
    if (index == 4) {
        enterButton.hidden = NO;
    }else {
        enterButton.hidden = YES;
    }
}

- (void)jumpToMainViewController {
    
    //第一次加载，设置配置文件
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = @"isNotFirstLaunch";
    [userDefaults setObject:@"Launch" forKey:key];
    
    MainTabBarController *main = [[MainTabBarController alloc] init];
    self.view.window.rootViewController = main;
}

- (BOOL)prefersStatusBarHidden {

    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
