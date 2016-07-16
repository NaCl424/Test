//
//  MineViewController.m
//  AfterTaste
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "MineViewController.h"
#import "RegisterOrLoginVC.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {

    [super viewDidLoad];

}
- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}


- (void)viewWillAppear:(BOOL)animated {

    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillLayoutSubviews {

    self.tableView.top = -55;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section ==3  && indexPath.row == 0) {

        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingTableVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {

        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterOrLoginVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    [self.navigationController setNavigationBarHidden:NO];
}
@end
