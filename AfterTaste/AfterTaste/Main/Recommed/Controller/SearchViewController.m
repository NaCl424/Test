//
//  SearchViewController.m
//  AfterTaste
//
//  Created by mac on 16/7/2.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
{

    UITextField *_searchText;
    UIButton *_textCancelButton;

}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    //自定义导航栏
    [self customNavigationBar];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)customNavigationBar {

    

    self.navigationItem.hidesBackButton = YES;
    CGFloat textViewHeight = 25;
    CGFloat textViewWidth = kScreenWidth * 4 /5;
    
    //搜索视图
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textViewWidth     , textViewHeight)];
    textView.backgroundColor = [UIColor grayColor];
    textView.layer.cornerRadius = 5;
    //左边搜索图标
    UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    searchImage.image = [UIImage imageNamed:@"search_icon_1"];
    searchImage.center = CGPointMake(textViewHeight /2, textViewHeight/2);
    [textView addSubview:searchImage];
    
    //创建搜索框
    _searchText = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, textView.frame.size.width - 60, 20)];
    _searchText.center = CGPointMake(textViewWidth / 2, textViewHeight /2);
    _searchText.font = [UIFont systemFontOfSize:12];
    _searchText.textColor = [UIColor whiteColor];
       //设置placeholder
    _searchText.placeholder = @"搜索目的地/餐厅/菜品/食记/用户";
    NSDictionary *attrabutes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSAttributedString *placegolderAttribute = [[NSAttributedString alloc] initWithString:_searchText.placeholder attributes:attrabutes];
    [_searchText setAttributedPlaceholder:placegolderAttribute];
    //监听textField值改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [textView addSubview:_searchText];
    
    //取消编辑
    _textCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _textCancelButton.frame = CGRectMake(0, 0, 10, 10);
    _textCancelButton.center = CGPointMake(textViewWidth - 12.5, textViewHeight/2);
    [_textCancelButton setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [_textCancelButton addTarget:self  action:@selector(textCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    _textCancelButton.hidden = YES;

    [textView addSubview:_textCancelButton];
 
    self.navigationItem.titleView = textView;
  
    
    
    //右边取消按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 35, 20);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

#pragma mark - buttonActions
- (void)textCancelAction:(UIButton *)button {
    
    
    _searchText.text = nil;

}

- (void)rightBarButtonItemAction:(UIButton *)button {

    [self.navigationController popViewControllerAnimated:YES];


}
#pragma mark  - UITextFieldTextDidChangeNotification
- (void)textFieldChanged:(NSNotification *)notification {

    UITextField *textField = notification.object;
    _textCancelButton.hidden = !textField.text.length;
    
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
