//
//  IsssueViewController.m
//  AfterTaste
//
//  Created by 林林 on 16/7/4.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "IsssueViewController.h"
#import "ImageViewCell.h"

@interface IsssueViewController () <UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>


@end

@implementation IsssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"我的食记";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //baritem
    [self createBarItem];
    
}

#pragma mark - createBarItem

- (void)createBarItem {
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 22, 22);
    [backButton setImage:[UIImage imageNamed:@"top_back_1"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = item;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleLabel.text = @"我的食记";
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //添加右边button
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    rightView.backgroundColor = [UIColor clearColor];
    rightView.userInteractionEnabled = YES;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 40, 30);
    [button1 setTitle:@"删除" forState:UIControlStateNormal];
    button1.titleLabel.textColor = [UIColor whiteColor];
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    button1.tag = 1;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(40, 0, 40, 30);
    [button2 setTitle:@"发布" forState:UIControlStateNormal];
    button2.titleLabel.textColor = [UIColor whiteColor];
    button2.titleLabel.font = [UIFont systemFontOfSize:14];
    button2.tag = 2;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button2];
    
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = itemRight;
}

#pragma mark - BarButton Action

- (void)backAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonAction:(UIButton *)button {
    
    if (button.tag == 1) {
        NSLog(@"删除");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒您" message:@"是否删除这个食记" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    } else if (button.tag == 2){
        NSLog(@"发布");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒您" message:@"发布成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITableDatasuorce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _imageArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        return firstCell;
    }
    ImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
    
    cell.noteImage = _imageArr[indexPath.row - 1];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 120;
    }
    return 200;
}

#pragma mark - 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
