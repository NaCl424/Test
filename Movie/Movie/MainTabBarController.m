//
//  MainTabBarController.m
//  Movie
//
//  Created by 林林 on 16/5/10.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainTabBarButton.h"

@interface MainTabBarController ()
{
    UIImageView *seletedImage;
}

@end

@implementation MainTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //加载storyboard
        [self loadSubViewController];
        //自定义tabBar样式
        [self customTabBar];
    }
    return self;
}
#pragma mark 加载storyboard
- (void)loadSubViewController {
    
    //创建storyboard名字数组
    NSArray *sbName = @[@"MovieStoryboard",
                        @"NewsStoryboard",
                        @"TopStoryboard",
                        @"CinemaStoryboard",
                        @"MoreStoryboard"];
    //读取的导航控制器数组
    NSMutableArray *navArr = [[NSMutableArray alloc] init];
    for (NSString *nameStr in sbName) {
        
        //加载故事版
        UIStoryboard *sb = [UIStoryboard storyboardWithName:nameStr bundle:[NSBundle mainBundle]];
        //读取导航控制器
        UINavigationController *nav = [sb instantiateInitialViewController];
        //导航控制器加入到数组中
        [navArr addObject:nav];
    }
    
    self.viewControllers = navArr;
    
}
#pragma mark 自定义tabBar样式
- (void)customTabBar {
    
    //添加背景图
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tab_bg_all"];
    
    //移除系统的tabBar按钮,以防与自定义的按钮发生冲突
    for (UIView *button in self.tabBar.subviews) {
        //判断是否为系统的按钮
        if ([button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //移除此按钮
            [button removeFromSuperview];
        }
    }
    
    //创建自定义的TabBar按钮
    NSArray *imageNames = @[@"movie_home",
                            @"msg_new",
                            @"start_top250",
                            @"icon_cinema",
                            @"more_select_setting"];
    NSArray *titles = @[@"电影",
                        @"新闻",
                        @"Top",
                        @"影院",
                        @"更多"];
    CGFloat buttonWidth = [UIScreen mainScreen].bounds.size.width / imageNames.count;
    for (int i = 0; i < imageNames.count; i++) {
        //计算Frame
        CGRect frame = CGRectMake(i * buttonWidth, 0, buttonWidth, 49);
        MainTabBarButton *button = [MainTabBarButton mainTabBarButtonWithImage:[UIImage imageNamed:imageNames[i]] title:titles[i] frame:frame];
        button.tag = i;
        [self.tabBar addSubview:button];
        [button addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    //完成按钮的点击事件
    seletedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, 49)];
    seletedImage.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    seletedImage.alpha = 0.8;
    [self.tabBar insertSubview:seletedImage atIndex:0];
    
}

- (void)tabBarButtonAction:(MainTabBarButton *)button {
    
    [UIView animateWithDuration:0.3 animations:^{
        seletedImage.center = button.center;
    }];
    self.selectedIndex = button.tag;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
