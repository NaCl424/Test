//
//  MovieDeatilViewController.m
//  Movie
//
//  Created by 林林 on 16/5/14.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "MovieDeatilViewController.h"
#import "CommentCell.h"
#import "CommentModel.h"

@interface MovieDeatilViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *dic;
    UIScrollView *scrollView;
    NSMutableArray *commentData;
    NSIndexPath *selectedIndexPath;
    CGFloat cellHeight;
}
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@end

@implementation MovieDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self loadData];
    
}

#pragma mark 获取数据
- (void)loadData {
    
    dic = [JSONDataService loadJsonFileWithName:@"movie_detail"];
    
    NSDictionary *commentDic = [JSONDataService loadJsonFileWithName:@"movie_comment"];
    NSArray *commentList = commentDic[@"list"];
    commentData = [[NSMutableArray alloc] init];
    for (NSDictionary *cDic in commentList) {
        CommentModel *commentModel = [[CommentModel alloc] initWithDictionary:cDic];
        [commentData addObject:commentModel];
    }
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return commentData.count+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopViewCell"];
        [self EditCell:cell];
        return cell;
    }else if(indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScrollViewCell"];
        scrollView = [cell viewWithTag:1006];
        scrollView.contentSize = CGSizeMake(KScreenWidth * 1.9, scrollView.frame.size.height);
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.layer.borderWidth = 2.0;
        scrollView.layer.borderColor = [[UIColor whiteColor] CGColor];
        scrollView.layer.cornerRadius = 8.0;
        scrollView.clipsToBounds = YES;
        [self creatImageInScrollView:scrollView];
        return cell;
    }else {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherViewCell"];
        [cell setCommentModel:commentData[indexPath.row-2]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 150;
    }else if (indexPath.row == 1) {
        return 100;
    }else if (selectedIndexPath != nil && [selectedIndexPath compare:indexPath] == NSOrderedSame) {
        //选中改变高度
        return cellHeight;
    }
    return 60;
}

#pragma mark 第一个单元格数据
- (void)EditCell:(UITableViewCell *)cell {
    //图片
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1000];
    NSURL *url = [NSURL URLWithString:dic[@"image"]];
    [imageView sd_setImageWithURL:url];
    //电影名
    UILabel *titleCn = (UILabel *)[cell viewWithTag:1001];
    titleCn.text = dic[@"titleCn"];
    //导演
    UILabel *director = (UILabel *)[cell viewWithTag:1002];
    director.text = [NSString stringWithFormat:@"导演:%@", [dic[@"directors"] lastObject]];
    //演员
    UILabel *actors = (UILabel *)[cell viewWithTag:1003];
    actors.text = @"主演:";
    NSArray *actorsArr = dic[@"actors"];
    for (NSString *str in actorsArr) {
        actors.text = [NSString stringWithFormat:@"%@ %@", actors.text, str];
    }
    //类型
    UILabel *type = (UILabel *)[cell viewWithTag:1004];
    type.text = @"类型:";
    NSArray *typeArr = dic[@"type"];
    for (NSString *str in typeArr) {
        type.text = [NSString stringWithFormat:@"%@ %@", type.text, str];
    }
    //地区和上映时间
    UILabel *release = (UILabel *)[cell viewWithTag:1005];
    NSDictionary *rDic = dic[@"release"];
    release.text = [NSString stringWithFormat:@"%@ %@", rDic[@"location"], rDic[@"date"]];
}
#pragma mark 创建滑动视图里的图片
- (void)creatImageInScrollView:(UIScrollView *)scroll {
    
    NSArray *images = dic[@"images"];
    for (int i = 0; i < images.count*2; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 + i*75, 10, 60, 60)];
        imageView.layer.cornerRadius = 8.0;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:images[i%images.count]];
        [scroll addSubview:imageView];
    }
    
}

#pragma mark Cell点击展开
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0 && indexPath.row != 1) {
        
        selectedIndexPath = indexPath;
        CommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.content.numberOfLines = 0;
        NSString *str = cell.content.text;
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(cell.commentBackView.frame.size.width - 10, 1000)];
        cell.content.size = size;
        cellHeight = size.height + 45;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
