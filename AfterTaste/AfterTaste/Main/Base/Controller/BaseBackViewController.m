//
//  BaseBackViewController.m
//  AfterTaste
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "BaseBackViewController.h"

@interface BaseBackViewController ()

@end

@implementation BaseBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;

    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
  //  self.tabBarController.tabBar.hidden = YES;
    [self creatLeftBarButtonItem];

}
- (void)creatLeftBarButtonItem {

    UINavigationController *nav = self.navigationController;
    if (!nav || nav.viewControllers.count == 1 ) {
        return;
    }
    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    itemButton.frame = CGRectMake(0, 0, 44, 44);
    [itemButton setTintColor:[UIColor whiteColor]];
    [itemButton setImage:[UIImage imageNamed:@"top_back_1.png"] forState:UIControlStateNormal];
    [itemButton addTarget:self action:@selector(itemButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)itemButtonAction {

    [self.navigationController popViewControllerAnimated:YES];
}

@end
