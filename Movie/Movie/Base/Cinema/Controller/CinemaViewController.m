//
//  CinemaViewController.m
//  Movie
//
//  Created by 林林 on 16/5/10.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "CinemaViewController.h"
#import "CinemaCell.h"
#import "Cinema.h"

@interface CinemaViewController ()
{
    NSArray *districtArr;
    NSMutableArray *cinemaArr;
    BOOL isSelected[19];
}

@end

@implementation CinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置代理
    _CinemaTableView.delegate = self;
    _CinemaTableView.dataSource = self;
    //读取数据
    //地区数据
    NSDictionary *dataDic = [JSONDataService loadJsonFileWithName:@"district_list"];
    districtArr = dataDic[@"districtList"];
    NSMutableArray *districtIDs = [[NSMutableArray alloc] init];
    //创建id数组
    for (NSDictionary *dic in dataDic[@"districtList"]) {
        [districtIDs addObject:dic[@"id"]];
    }
    
    //影院数据
    cinemaArr = [[NSMutableArray alloc] init];
    NSDictionary *cinemaData = [JSONDataService loadJsonFileWithName:@"cinema_list"];
    //创建二维数组存放数据
    for (int i = 0; i < districtIDs.count; i++) {
        NSMutableArray *inArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in cinemaData[@"cinemaList"]) {
            if ([dic[@"districtId"] isEqualToString:districtIDs[i]]) {
                Cinema *cinema = [[Cinema alloc] initWithDictionary:dic];
                [inArr addObject:cinema];
            }
        }
        [cinemaArr addObject:inArr];
    }
    
    
    //注册单元格
    [_CinemaTableView registerNib:[UINib nibWithNibName:@"CinemaCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CinemaCell"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isSelected[section]) {
        NSArray *array = cinemaArr[section];
        return array.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CinemaCell"];
    NSArray *array = cinemaArr[indexPath.section];
    [cell setCinema:array[indexPath.row]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return districtArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //添加头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    headerView.backgroundColor = [UIColor cyanColor];
    UIImageView *headerbgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hotMovieBottomImage"]];
    [headerView addSubview:headerbgImage];
    //添加地区名
    UILabel *headerTitle = [[UILabel alloc] initWithFrame:headerView.bounds];
    NSDictionary *dic = districtArr[section];
    headerTitle.text = dic[@"name"];
    headerTitle.textAlignment = NSTextAlignmentCenter;
    headerTitle.textColor = [UIColor whiteColor];
    [headerView addSubview:headerTitle];
    //添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = headerView.frame;
    button.backgroundColor = [UIColor clearColor];
    button.tag = section;
    [headerView addSubview:button];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)buttonAction:(UIButton *)button {
    
    isSelected[button.tag] = !isSelected[button.tag];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:button.tag];
    [_CinemaTableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
    //滚动到点击的组
    if (isSelected[button.tag]) {
        [_CinemaTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:button.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
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
