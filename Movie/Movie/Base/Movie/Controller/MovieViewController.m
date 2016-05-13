//
//  MovieViewController.m
//  Movie
//
//  Created by 林林 on 16/5/10.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "MovieViewController.h"
#import "Movie.h"
#import "MovieCell.h"
#import "JSONDataService.h"

@interface MovieViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_movies;
}
@property (weak, nonatomic) IBOutlet UIView *postView;
@property (weak, nonatomic) IBOutlet UITableView *listView;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self loadJsonFile];
    //创建导航栏按钮
    [self creatRightButton];
    //设置表视图初始偏移
    _listView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    
    [_listView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MovieCell"];
    
}

//加载数据
- (void)loadJsonFile {
    
    
    NSDictionary *result = [JSONDataService loadJsonFileWithName:@"us_box"];
    
    _movies = [[NSMutableArray alloc] init];
    //    NSLog(@"%@", result);
    for (NSDictionary *dict in result[@"subjects"]) {
        //创建Model对象
        Movie *m = [[Movie alloc] initWithDictionary:dict];
//        NSLog(@"%@", m);
        [_movies addObject:m];
    }
    
}


//创建按钮
- (void)creatRightButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置frame
    button.frame = CGRectMake(0, 0, 49, 25);
    //设置背景图片
    [button setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    //设置按钮图片
    [button setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateSelected];
    //添加按钮点击
    [button addTarget:self action:@selector(exchangeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //将按钮添加到导航栏
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    
}

- (void)exchangeButtonAction:(UIButton *)button {
    
    //根据当前状态决定翻转方向
    UIViewAnimationOptions option = button.selected?UIViewAnimationOptionTransitionFlipFromLeft:UIViewAnimationOptionTransitionFlipFromRight;
    
    //按钮翻转动画
    [UIView transitionWithView:button duration:0.4 options:option animations:^{
        //按钮状态
        button.selected = !button.selected;
    } completion:nil];
    
    //UIView过场动画
    [UIView transitionWithView:self.view duration:0.4 options:option animations:^{
        //改变视图
        _postView.hidden = !button.selected;
        _listView.hidden = button.selected;
    } completion:nil];
    
    
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
//    NSLog(@"cell=%@", cell);
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieCell" owner:nil options:nil] lastObject];
//    }
    
    cell.movie = _movies[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
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
