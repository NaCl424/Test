//
//  LaunchViewController.m
//  Movie
//
//  Created by 林林 on 16/5/20.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "LaunchViewController.h"
#import "MainTabBarController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 1; i <= 24; i++) {
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:i];
        UIImage *postImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
        imageView.image = postImage;
        imageView.alpha = 0;
    }
    [self showImageView];

}

- (void)showImageView {
    
    for (int i = 0; i <= 24; i++) {
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:i];
        //动画
        [UIView animateWithDuration:0.1
                              delay:(i-1)*0.1
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:^{
                             imageView.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             if (i == 24) {
                                 [self jumpToMainViewController];
                             }
                         }];
        
        
    }
    
}

- (void)jumpToMainViewController {
    
    MainTabBarController *main = [[MainTabBarController alloc] init];
    self.view.window.rootViewController = main;
    //给弹出的主界面加动画
//    main.view.transform = CGAffineTransformMakeTranslation(0, KScreenHeight * 2);
//    [UIView animateWithDuration:0.5 animations:^{
//        main.view.transform = CGAffineTransformIdentity;
//    }];
    
    
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
