 //
//  GlobalTableViewController.m
//  AfterTaste
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 ljp. All rights reserved.
//

#import "GlobalTableViewController.h"
#import "CorCViewController.h"
#import "CityViewController.h"
#import "SearchViewController.h"

#define kTableViewSpace 10

@interface GlobalTableViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_continentArray;

}
@end

@implementation GlobalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatBarItem];
//    [self continentRequest];
    [self loadJsonFile];

}
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

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
    self.tableView.frame = CGRectMake(kTableViewSpace, 0, kScreenWidth - 2 * kTableViewSpace, kScreenHeight);
}

#pragma mark - request
- (void)continentRequest {

    NSString *urlString = @"http://www.youyuwei.com/api/find?app_code=com.youyuwei.yuwei.ios&hardware_model=iPhone4%2C1&app_ver=2.8.1&sys_ver=7.1&device_type=ios&ywsdk_ver=20131018&x_auth_mode=client_auth&open_udid=451fbec87179faac60d36488695c4b7d69b37026&start=0&oauth_timestamp=1467440263&device_token=&oauth_signature_method=HMAC-SHA1&ver=4&idfa=D478D356-B3D9-47A7-BCED-DD18BC6EC4BA&channel_id=App%20Store&oauth_version=1.0&oauth_consumer_key=4&oauth_token=0_9837387abc30183c39&oauth_signature=CoEUrggDpbGiY92f5dAyMigiikg%3D&debug=0&oauth_nonce=6a7ceb831ea50d4e49b8ac9beb656a84";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableLeaves];

    [manager GET:urlString
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {

             _continentArray = [[NSMutableArray alloc] init];
             NSArray *listArray = responseObject[@"data"][@"list"];

             for (int i = 0; i < listArray.count; i++) {
                 NSDictionary *dic = listArray[i];
                 if (i == listArray.count - 1) {
                     Country *country = [[Country alloc] init];
                     country.name = dic[@"title"];
                     NSMutableArray *cities = [[NSMutableArray alloc] init];
                     for (NSDictionary *dic2 in dic[@"content"]) {
                         City *city = [[City alloc] init];
                         city.name = dic2[@"name"];
                         city.imageName = dic2[@"cover"];
                         [cities addObject:city];
                     }
                     country.cities = [cities copy];
                     [_continentArray addObject:country];

                 }else {

                     Continent *continent = [[Continent alloc] init];
                     NSMutableArray *countries = [[NSMutableArray alloc] init];
                     for (NSDictionary *dic2 in dic[@"content"]) {
                         Country *country = [[Country alloc] init];
                         country.name = dic2[@"name"];
                         country.imageName = dic2[@"cover"];

                         [countries addObject:country];
                     }
                     continent.name = dic[@"title"];
                     continent.countries = [countries copy];
                     [_continentArray addObject:continent];
                 }

             }
             [self.tableView reloadData];
         }
         failure:nil];
}
- (void)loadJsonFile {

    NSDictionary *responseObject = [JSONDataService loadJSONFielWithName:@"Continent"];
    _continentArray = [[NSMutableArray alloc] init];
    NSArray *listArray = responseObject[@"data"][@"list"];

    for (int i = 0; i < listArray.count; i++) {
        NSDictionary *dic = listArray[i];
        if (i == listArray.count - 1) {
            Country *country = [[Country alloc] init];
            country.name = dic[@"title"];
            NSMutableArray *cities = [[NSMutableArray alloc] init];
            for (NSDictionary *dic2 in dic[@"content"]) {
                City *city = [[City alloc] init];
                city.name = dic2[@"name"];
                city.imageName = dic2[@"cover"];
                [cities addObject:city];
            }
            country.cities = [cities copy];
            [_continentArray addObject:country];

        }else {

            Continent *continent = [[Continent alloc] init];
            NSMutableArray *countries = [[NSMutableArray alloc] init];
            for (NSDictionary *dic2 in dic[@"content"]) {
                Country *country = [[Country alloc] init];
                country.name = dic2[@"name"];
                country.imageName = dic2[@"cover"];

                [countries addObject:country];
            }
            continent.name = dic[@"title"];
            continent.countries = [countries copy];
            [_continentArray addObject:continent];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source
//单元格个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _continentArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContinentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContinentCell" owner:nil options:nil] lastObject];
    }
    NSString *backgroundImageName = [NSString stringWithFormat:@"find_list_b%i", indexPath.section + 1];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:backgroundImageName]];


    if (indexPath.section == _continentArray.count - 1) {

        Country *country = _continentArray[indexPath.section];
        country.index = indexPath.section;
        cell.cellObject = country;

        cell.countryBlock = ^{

            CorCViewController * vc = [[CorCViewController alloc] init];
            country.index = indexPath.section % 3;
//            [country countryRequestWithContinentIndex:indexPath.section];
            [country loadJsonFileWithContinentIndex:indexPath.section];
            vc.country = country;
            [self.navigationController pushViewController:vc animated:YES];

        };

        cell.cityBlock = ^(NSInteger index){

            CityViewController *vc = [[CityViewController alloc] init];
            City *city = country.cities[index];
            city.index = index % 4;
//            [city cityRequestWithCountryIndex: indexPath.section % 3];
            [city loadJsonFileWithCountryIndex:indexPath.section % 3];
            vc.city = city;
            [self.navigationController pushViewController:vc animated:YES];
        };
    } else {

        Continent *continent = _continentArray[indexPath.section];
        continent.index = indexPath.section;
        cell.cellObject = continent;

        cell.countryBlock = ^{

            CorCViewController * vc = [[CorCViewController alloc] init];
            vc.continent = continent;

            [self.navigationController pushViewController:vc animated:YES];

        };
        cell.cityBlock = ^(NSInteger index){

            Country *country = continent.countries[index];
            country.index = index % 3;
//            [country countryRequestWithContinentIndex:continent.index];
            [country loadJsonFileWithContinentIndex:continent.index];
            CorCViewController * vc = [[CorCViewController alloc] init];
            vc.country = country;

            [self.navigationController pushViewController:vc animated:YES];
            
        };
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}


@end
