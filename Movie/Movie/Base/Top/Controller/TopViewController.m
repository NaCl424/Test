//
//  TopViewController.m
//  Movie
//
//  Created by 林林 on 16/5/10.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "TopViewController.h"
#import "JSONDataService.h"
#import "TopModel.h"
#import "TopCell.h"

@interface TopViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_dataArr;
}
@property (weak, nonatomic) IBOutlet UICollectionView *topCollectionView;


@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self loadJsonFile];
    //注册
    [_topCollectionView registerNib:[UINib nibWithNibName:@"TopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"TopCell"];
}

- (void)loadJsonFile {
    
    NSDictionary *data = [JSONDataService loadJsonFileWithName:@"top250"];
    _dataArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in data[@"subjects"]) {
        
        TopModel *topModel = [[TopModel alloc] initWithDictionary:dic];
        [_dataArr addObject:topModel];
    }
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
    
    [cell setTopModel:_dataArr[indexPath.row]];
    
    return cell;
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
