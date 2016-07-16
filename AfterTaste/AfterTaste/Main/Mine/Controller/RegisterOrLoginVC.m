//
//  RegisterOrLoginVC.m
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "RegisterOrLoginVC.h"

@interface RegisterOrLoginVC ()

@property (strong, nonatomic) IBOutlet UIView *registerView;
@property (strong, nonatomic) IBOutlet UIView *loginView;

@end

@implementation RegisterOrLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];
    //上移
    self.view.top = -10;
    [self createItemButton];
}
- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}

- (IBAction)topRegisterButton:(UIButton *)sender {

    [UIView animateWithDuration:0.4 animations:^{

        _registerView.hidden = NO;
        _loginView.hidden = YES;
    }];
}

- (IBAction)topLoginButton:(id)sender {

    [UIView animateWithDuration:0.4 animations:^{

        _registerView.hidden = YES;
        _loginView.hidden = NO;
    }];
}
- (void)createItemButton {

    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    itemButton.frame = CGRectMake(0, 0, 44, 44);
    [itemButton addTarget:self action:@selector(itemButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [itemButton setImage:[UIImage imageNamed:@"top_back_1.png"] forState:UIControlStateNormal];
    [self.view addSubview:itemButton];

}
- (void)itemButtonAction {

    [self.navigationController popViewControllerAnimated:YES];
}
@end
