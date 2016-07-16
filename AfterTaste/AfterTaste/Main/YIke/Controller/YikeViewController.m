//
//  YikeViewController.m
//  AfterTaste
//
//  Created by 林林 on 16/6/29.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "YikeViewController.h"
#import "TopicModel.h"
#import "TopicCell.h"
#import "CameraViewController.h"

@interface YikeViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tbView;
    NSMutableArray *_dataArr;
    UIWindow *_cameraWindow;
    UIButton *_cameraButton;
}

@end

@implementation YikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleLabel.text = @"一刻";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    [self loadData];
    [self createTableView];
    
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"TopicCell" bundle:[NSBundle mainBundle]];
    [_tbView registerNib:nib forCellReuseIdentifier:@"TopicCell"];
}

- (void)loadData {
    
    _dataArr = [[NSMutableArray alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"yike" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data != nil) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dic = result[@"data"];
        NSArray *arr = dic[@"list"];
        NSDictionary *dic2 = [arr lastObject];
        for (NSDictionary *data in dic2[@"data"]) {
            TopicModel *model = [[TopicModel alloc] initWithDic:data];
            [_dataArr addObject:model];
        }
    }
    
}

- (void)createTableView {
    
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell"];
    cell.model = _dataArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 3, 20)];
    leftView.backgroundColor = [UIColor orangeColor];
    [view addSubview:leftView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 100, 30)];
    label.text = @"热门话题";
    label.font = [UIFont systemFontOfSize:16];
    [view addSubview:label];
    
    return view;
}

#pragma mark - 添加悬浮按钮
- (void)viewWillAppear:(BOOL)animated {
    
    //创建按钮
    _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cameraButton.frame = CGRectMake(0, 0, 66, 66);
    [_cameraButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cameraButton setImage:[UIImage imageNamed:@"topic_crame"] forState:UIControlStateNormal];
    
    //创建UIWindow
    _cameraWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
    _cameraWindow.center = CGPointMake(kScreenWidth / 2, kScreenHeight - (49 + 20 + 33));
    _cameraWindow.windowLevel = UIWindowLevelAlert + 1;
    [_cameraWindow addSubview:_cameraButton];
    [_cameraWindow makeKeyAndVisible];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (_cameraWindow == nil) {
        return;
    }
    [_cameraWindow resignKeyWindow];
    _cameraWindow = nil;
    
}

#pragma mark - 悬浮按钮点击事件
- (void)clickButtonAction:(UIButton *)button {
    
    CameraViewController *vc = [[CameraViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end









