//
//  NewsViewController.m
//  Movie
//
//  Created by 林林 on 16/5/10.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "NewsViewController.h"
#import "JSONDataService.h"
#import "News.h"
#import "UIImageView+WebCache.h"

@interface NewsViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_newsArr;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self loadJsonFile];

    
}

- (void)loadJsonFile {
    
    NSArray *result = [JSONDataService loadJsonFileWithName:@"news_list"];
    _newsArr = [[NSMutableArray alloc] init];
//    NSLog(@"%@", result);
    for (NSDictionary *dic in result) {
        News *n = [[News alloc] initWithDictionary:dic];
        [_newsArr addObject:n];
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _newsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TopNewsCell"];
        //获取第一个单元格数据
        News *n = [_newsArr firstObject];
        UIImageView *topImageView = (UIImageView *)[cell.contentView viewWithTag:100];
        UILabel *topLabel = (UILabel *)[cell.contentView viewWithTag:101];
        //填充数据
        [topImageView sd_setImageWithURL:[NSURL URLWithString:n.image]];
        topLabel.text = n.title;
        
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    }
    
    
    return cell;
    
}- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 180;
    }
    return 80;
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
