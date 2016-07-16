//
//  SJWebViewController.m
//  AfterTaste
//
//  Created by 林林 on 16/7/3.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "SJWebViewController.h"

@interface SJWebViewController ()
{
    UIWebView *_webView;
    UIView *_backView;
    UIView *_toolView;
}

@end

@implementation SJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_webView];
    //添加评论栏
    [self createToolView];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlStr]];
    [_webView loadRequest:request];
    
    //添加返回手势
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    _backView.backgroundColor = [UIColor clearColor];
    [_webView addSubview:_backView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    [_backView addGestureRecognizer:tap];
    
    //监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidClose:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)backAction:(UISwipeGestureRecognizer *)swip {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - toolBar
- (void)createToolView {
    
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 40, kScreenWidth, 40)];
    _toolView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_toolView];
    
    UITextField *comment = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, kScreenWidth - 80 - 25, 30)];
    comment.layer.cornerRadius = 8;
    comment.layer.borderWidth = 1;
    comment.layer.borderColor = [UIColor grayColor].CGColor;
    comment.alpha = 0.8;
    comment.placeholder = @"评论这篇食记";
    comment.borderStyle = UITextBorderStyleRoundedRect;
    [_toolView addSubview:comment];
    
    UILabel *rightView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 27)];
    rightView.text = @"44评论";
    rightView.textColor = [UIColor lightGrayColor];
    rightView.font = [UIFont systemFontOfSize:14];
    rightView.textAlignment = NSTextAlignmentCenter;
    rightView.backgroundColor = [UIColor whiteColor];
    rightView.alpha = 0.8;
    rightView.layer.cornerRadius = 10;
    rightView.layer.borderWidth = 1;
    rightView.layer.borderColor = [UIColor grayColor].CGColor;
    rightView.layer.masksToBounds = YES;
    rightView.left = comment.right + 10;
    rightView.bottom = comment.bottom;
    [_toolView addSubview:rightView];
}

#pragma mark - 键盘
- (void)keyboardDidShow:(NSNotification *)notification {
    
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _toolView.bottom = kScreenHeight - frame.size.height;
}

- (void)keyboardDidClose:(NSNotification *)notification {
    _toolView.bottom = kScreenHeight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
