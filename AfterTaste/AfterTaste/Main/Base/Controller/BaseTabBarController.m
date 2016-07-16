//
//  BaseTabBarController.m
//  AfterTaste
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 Czj. All rights reserved.
//


#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *backView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    backView.backgroundColor = kBarColor;
    [self.tabBar insertSubview:backView atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (instancetype)init {
    
    if (self) {
        
        [self loadSubViewControllers];
        
    }
    
    return self;
}

- (void)loadSubViewControllers {
    
    //加载5个故事版文件,读取其中的NavigationController
    NSArray *sbNameArray = @[@"RecommendStoryboard",
                             @"GlobalStoryboard",
                             @"Yike",
                             @"Shiji",
                             @"MineStoryboard"];
    NSArray *titleArray = @[@"推荐", @"全球", @"一刻", @"食记", @"我的"];
    NSArray *imageArray = @[@"tab_recommend",@"tab_find", @"tab_onetime", @"tab_daily", @"tab_mine"];
    NSArray *selectedImageArray = @[@"tab_recommend_orange",@"tab_find_orange", @"tab_onetime_orange", @"tab_daily_orange", @"tab_mine_orange"];
    
    
    UIColor *selectedColor = [UIColor colorWithRed:240/255.0 green:143/255.0 blue:38/255.0 alpha:1];
    UIColor *nomalColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    
    //遍历故事版名字数组
    for (int i = 0; i < sbNameArray.count; i ++) {
        
        //读取故事版文件
        UIStoryboard *sb = [UIStoryboard storyboardWithName:sbNameArray[i] bundle:[NSBundle mainBundle]];
        
        //获取故事版的入口控制器
        UINavigationController *nac =[sb instantiateInitialViewController];
        
        //设置tabBar样式
        nac.tabBarItem.title = titleArray[i];
        nac.tabBarItem.image = [[UIImage imageNamed:imageArray[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [nac.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : nomalColor} forState:UIControlStateNormal];
        nac.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [nac.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : selectedColor} forState:UIControlStateSelected];
        //添加子控制器
       // [self addChildViewController:nac];
        [mArray addObject:nac];
    }
    
    self.viewControllers = mArray;
    self.selectedIndex = 0;

    
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
