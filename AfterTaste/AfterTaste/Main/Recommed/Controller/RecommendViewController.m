//
//  RecommendViewController.m
//  AfterTaste
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommentHeaderView.h"
#import "RecommendCell1.h"
#import "SJCell.h"
#import "SJCellModel.h"
#import "SJWebViewController.h"
#import "SearchViewController.h"
@interface RecommendViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    
    NSArray *_titleArray;
    NSArray *_subTitleArray;

    NSArray *_listArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //20间隙
    self.automaticallyAdjustsScrollViewInsets = NO;

    _titleArray = @[@"当季热门", @"每日精选"];
    _subTitleArray = @[@"此刻风味正好", @"24小时的新鲜"];

    //关闭弹性
    _tableView.bounces = NO;
    //注册cell
    UINib *nib = [UINib nibWithNibName:@"SJCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"SJCell"];
    
    [self loadJsonFile];
    [self creatBarItem];
}

- (void)loadJsonFile {

    NSDictionary *dic = [JSONDataService loadJSONFielWithName:@"RecommentJson"];
    _listArray = dic[@"data"][@"list"];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //隐藏导航栏
    [self scrollViewDidScroll:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自定义导航栏
- (void)creatBarItem {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    imageView.image = [UIImage imageNamed:@"icon_58"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 7, kScreenWidth - 100, 26)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.layer.cornerRadius = 5;
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, 20, 20)];
    searchImageView.image = [UIImage imageNamed:@"search_error"];
    searchImageView.backgroundColor = [UIColor clearColor];
    [view addSubview:searchImageView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 160, 26)];
    
    lable.text = @"寻找你想去吃的地方";
    lable.font = [UIFont systemFontOfSize:12];
    lable.textColor = [UIColor whiteColor];
    lable.backgroundColor = [UIColor clearColor];
    [view addSubview:lable];
    
    //搜索框添加单击手势
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchTapAC)];
    searchTap.numberOfTapsRequired = 1;
    searchTap.numberOfTouchesRequired = 1;
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:searchTap];
    
    
    
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    self.navigationItem.leftBarButtonItem = leftItem1;
    self.navigationItem.titleView = view;
    
}
- (void)searchTapAC {
    
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    
    UINavigationController *naviCtl = [self navigationController];
    
    [naviCtl pushViewController:searchVC animated:YES];
    [naviCtl setNavigationBarHidden:NO animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    
    CGFloat offsetX = scrollView.contentOffset.y;
    if (offsetX > kScreenWidth / 1.5 - 20 ) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        }];
        
    }else {
        
        [UIView animateWithDuration:0.2 animations:^{
            
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        }];

    }
}

#pragma mark - UITabelViewDelegate

//跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        NSArray *arr = _listArray[4][@"content"];
        NSDictionary *dic = [arr firstObject];
        SJCellModel *model = [[SJCellModel alloc] initWithDictionary:dic];
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
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return _titleArray.count + 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        
        return 0;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1) {

        NSArray *contentArray = _listArray[3][@"content"];

        RecommendCell1 *cell = [[RecommendCell1 alloc] init];
        cell.array = contentArray;
        return cell;
    } else if (indexPath.section == 2) {
        
        NSArray *arr = _listArray[4][@"content"];
        NSDictionary *dic = [arr firstObject];
        SJCellModel *model = [[SJCellModel alloc] initWithDictionary:dic];
        SJCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SJCell"];
        cell.sjCellModel = model;
        return cell;
    }

    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.section == 1){
        return 2*(kItemWidth + kCollectionViewSpace + 20);
    } else if (indexPath.section == 2) {
        return 250;
    }
    return 20;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        
        return kScreenWidth / 1.5;
        
    }else  {
        
        return 40;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        NSArray *HeaderViewNib = [[NSBundle mainBundle] loadNibNamed:@"RecommendHeaderView" owner:self options:nil];
        RecommentHeaderView *headerView = [HeaderViewNib firstObject];
        
        return headerView;
    }else  {
        
        return [self createHeaderViewWithTitle:_titleArray[section-1] subTitle:_subTitleArray[section-1]];
    }
    
}

//第二三四组的headerView
#pragma mark - createHeaderView

- (UIView *)createHeaderViewWithTitle:(NSString*)title subTitle:(NSString *)subTitle {

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 60)];
    UIView *orangeView = [[UIView alloc] initWithFrame:CGRectMake(20, 7, 3, 15)];
    orangeView.backgroundColor = [UIColor orangeColor];
    [headerView addSubview:orangeView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 200, 20)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = title;
    [headerView addSubview:titleLabel];
    
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 200, 15)];
    subTitleLabel.font = [UIFont systemFontOfSize:14];
    subTitleLabel.textColor = [UIColor grayColor];
    subTitleLabel.text = subTitle;
    [headerView addSubview:subTitleLabel];
    
    
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;

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
