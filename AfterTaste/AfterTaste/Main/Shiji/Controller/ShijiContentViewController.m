//
//  ShijiContentViewController.m
//  AfterTaste
//
//  Created by 林林 on 16/7/3.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "ShijiContentViewController.h"
#import "SJCell.h"
#import "SJCellModel.h"
#import "AFNetworking.h"
#import "SJWebViewController.h"

@interface ShijiContentViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tbView;
    NSMutableArray *_dataArr;
    NSMutableArray *_modelArr;
}

@end

@implementation ShijiContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建table
    [self createTableView];
    //数据加载
//    [self HotlistDataRequest];
    //注册cell
    UINib *nib = [UINib nibWithNibName:@"SJCell" bundle:[NSBundle mainBundle]];
    [_tbView registerNib:nib forCellReuseIdentifier:@"SJCell"];
}

#pragma mark - 数据加载
//- (void)HotlistDataRequest {
//
//    NSString *urlString = @"http://www.youyuwei.com/api/note?";
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableLeaves];
//    NSDictionary *parameters = @{@"ywsdk_ver" : @"20131018",
//                                 @"app_code" : @"com.youyuwei.yuwei.ios",
//                                 @"oauth_version" : @"1.0",
//                                 @"oauth_timestamp" : @"1467263619",
//                                 @"oauth_nonce" : @"b01a79bbbaacc2134e5e52e2430aa25c",
//                                 @"oauth_signature" : @"C5eGFxGFTTQSIQOFGOPgdz9wylE=",
//                                 @"sys_ver" : @"9.3.2",
//                                 @"hardware_model" : @"iPhone6,2",
//                                 @"oauth_consumer_key" : @"4",
//                                 @"device_token" : @"",
//                                 @"ver" : @"4",
//                                 @"list" : @"Hotlist",
//                                 @"oauth_signature_method" : @"HMAC-SHA1",
//                                 @"debug" : @"0",
//                                 @"app_ver" : @"2.8.1",
//                                 @"x_auth_mode" : @"client_auth",
//                                 @"oauth_token" : @"0_9837387abc30183c39",
//                                 @"channel_id" : @"App Store",
//                                 @"start" : @"0",
//                                 @"open_udid" : @"939c4f2c2c59b42c0fa40508f981ea1fa8144876",
//                                 @"device_type" : @"ios",
//                                 @"idfa" : @"AC2DA911-0E11-4599-AA43-DC5AA18CCE2A"};
//    
//    
//    
//    [manager GET:urlString
//      parameters:parameters
//         success:^(NSURLSessionDataTask *task, id responseObject) {
//             NSLog(@"成功,%@", responseObject);
//         }
//         failure:^(NSURLSessionDataTask *task, NSError *error) {
//             NSLog(@"错误,%@", error);
//         }];

//}

- (void)setRequsetType:(NSInteger)type {
    
    _modelArr = [[NSMutableArray alloc] init];
    NSString *filePath = nil;
    if (type == 0) {
        
        filePath = [[NSBundle mainBundle] pathForResource:@"host" ofType:@"json"];
    } else if (type == 1) {
        filePath = [[NSBundle mainBundle] pathForResource:@"new" ofType:@"json"];
    }
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data != nil) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dic = result[@"data"];
        _dataArr = dic[@"list"];
    }
    
    for (NSDictionary *dic in _dataArr) {
        SJCellModel *cellModel = [[SJCellModel alloc] initWithDictionary:dic];
        [_modelArr addObject:cellModel];
    }

}

#pragma mark - 创建tableView
- (void)createTableView {
    
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 64 - 35) style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
//    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tbView];
    
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SJCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SJCell"];
    cell.sjCellModel = _modelArr[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 250;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SJCellModel *model = _modelArr[indexPath.row];
    NSString *string = model.url;
    NSString *urlStr = nil;
    if ([string hasPrefix:@"http://"]) {
        urlStr = string;
    } else {
        string = [string substringFromIndex:7];
        urlStr = [NSString stringWithFormat:@"http://www.youyuwei.com%@", string];
    }
    
    SJWebViewController *webVC = [[SJWebViewController alloc] init];
    webVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    webVC.urlStr = urlStr;
    webVC.hidesBottomBarWhenPushed = YES;
    [self presentViewController:webVC animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSDictionary *userInfo = @{@"OffsetY" : [NSNumber valueWithCGPoint:scrollView.contentOffset]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kScrollContentOffsetNotification object:self userInfo:userInfo];
    
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
