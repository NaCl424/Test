//
//  NearbyViewController.m
//  AfterTaste
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "NearbyViewController.h"
#import "RestListCollectionView.h"
@interface NearbyViewController ()
{
    RestListCollectionView * _contentView;
}
@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取数据
    //自定义导航栏
    [self customNavigationBar];
    //创建内容视图
    [self createRestViewAndMapView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    NSLog(@"NEARBY kill");

}


#pragma mark - 布置UI
- (void)customNavigationBar {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    NSDictionary *dataDic = _response[@"data"];
    NSDictionary *cityInfo = dataDic[@"cityinfo"];
    //titleView
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    titleLabel.text = cityInfo[@"name"];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    //left
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 22, 22);
    [leftButton setImage:[UIImage imageNamed:@"top_back_1"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(topLeftButtonAC:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //right
    UIButton *rightMapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightMapButton.frame = CGRectMake(0, 0, 22, 22);
    [rightMapButton setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
    [rightMapButton setImage:[UIImage imageNamed:@"city_new_back_map"] forState:UIControlStateSelected];
    [rightMapButton addTarget:self action:@selector(topRightMapButtonAC:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightMapItem = [[UIBarButtonItem alloc] initWithCustomView:rightMapButton];
    
    UIButton *rightShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightShareButton.frame = CGRectMake(0, 0, 22, 22);
    [rightShareButton setImage:[UIImage imageNamed:@"top_share_1"] forState:UIControlStateNormal];
    [rightShareButton addTarget:self action:@selector(topRightShareButtonAC:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightShareItem = [[UIBarButtonItem alloc] initWithCustomView:rightShareButton];
    
    NSArray *rightItems = @[rightShareItem, rightMapItem];
    self.navigationItem.rightBarButtonItems = rightItems;

}



- (void)createRestViewAndMapView {

    NSDictionary *dataDic = _response[@"data"];
    NSArray *titles = dataDic[@"list"];
    //顶部工具栏
    _topToolView = [[TopToolScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) andTitles:titles];
    [self.view addSubview:_topToolView];
    
    
    
    
    //内容视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - 50);
    layout.minimumLineSpacing = 0.0 ;
    layout.sectionInset = UIEdgeInsetsMake(0, 0,0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _contentView = [[RestListCollectionView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - 50) collectionViewLayout:layout dataArray:titles];
    _contentView.isMap = NO;
    
    //内容页码改变的block
    __weak NearbyViewController *weakSelf = self;
    _contentView.changePageBlock = ^(NSUInteger index) {
    
        weakSelf.topToolView.selectedIndex = index;
        
    
    };
    
    [self.view addSubview:_contentView];
    
    __weak RestListCollectionView *weakView = _contentView;
        //顶部toolView点击时block
        _topToolView.toolViewBolck = ^(NSInteger index) {
    
            if (!weakView.isMap) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                [weakView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            }else {
            
                weakView.mapPage = index;
                
            }
        };

}



#pragma mark - topButtonActions
- (void)topLeftButtonAC:(UIButton *)button {

    [self.navigationController popViewControllerAnimated:YES];


}

- (void)topRightMapButtonAC:(UIButton *)button {
    
    [UIView transitionWithView:self.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
        button.selected = !button.selected;
        button.userInteractionEnabled = NO;
        
        //切换为地图时,不可滑动
        _contentView.isMap = button.selected;
        if (_contentView.isMap) {
            
            _contentView.mapPage = _topToolView.selectedIndex;
        }
    } completion:^(BOOL finished) {
        
        button.userInteractionEnabled = YES;
    }];
    
    
    
}


- (void)topRightShareButtonAC:(UIButton *)button {

    NSLog(@"分享");


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
