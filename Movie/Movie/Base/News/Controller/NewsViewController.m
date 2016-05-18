//
//  NewsViewController.m
//  Movie
//
//  Created by 林林 on 16/5/10.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "NewsViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "ImageListViewController.h"
#import "WebNewsViewController.h"


@interface NewsViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    NSMutableArray *_newsArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tbView;

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
        //剩下的cell
        cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
        NewsCell *newsCell = (NewsCell *)cell;
        News *n = _newsArr[indexPath.row];
        [newsCell setNews:n];
    }
    
    
    return cell;
    
}- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 180;
    }
    return 80;
}
#pragma mark 下拉放大
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //获取偏移量
    CGFloat yOffset = _tbView.contentOffset.y;
    //获取视图
    UITableViewCell *cell = [_tbView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIImageView *topImage = (UIImageView *)[cell.contentView viewWithTag:100];
    if (yOffset < -64) {
        //实现放大
        CGFloat scale = (180 + (-64 - yOffset)) / 180;
        topImage.transform = CGAffineTransformMakeScale(scale, scale);
        //消除裁剪
        cell.clipsToBounds = NO;
        cell.contentView.clipsToBounds = NO;
        //顶部贴合导航栏
        topImage.top = yOffset + 64;
    }
}

#pragma mark 添加点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    News *n = _newsArr[indexPath.row];
    switch (n.type) {
        case NewsTypeNone:
        {
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebNewsViewController"];
            //隐藏底部标签栏
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case NewsTypeImage:
        {
            ImageListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageListViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case NewsTypeVedio:
        {
            NSLog(@"视频新闻");
            break;
        }
        default:
            break;
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
