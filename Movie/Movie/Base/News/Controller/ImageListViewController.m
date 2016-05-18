//
//  ImageListViewController.m
//  Movie
//
//  Created by 林林 on 16/5/14.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "ImageListViewController.h"
#import "HNImageViewController.h"

@interface ImageListViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    NSArray *_dataArr;
}

@end

@implementation ImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)loadData {
    
    NSArray *array = [JSONDataService loadJsonFileWithName:@"image_list"];
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array) {
        NSURL *url = [NSURL URLWithString:dic[@"image"]];
        [mArr addObject:url];
        
    }
    _dataArr = [mArr copy];
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewsImageCell" forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:12345];
    [imageView sd_setImageWithURL:_dataArr[indexPath.item]];
    //设置图片边框
    cell.layer.borderColor = [[UIColor grayColor] CGColor];
    cell.layer.borderWidth = 1;
    cell.layer.cornerRadius = 3;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat kwidth = ([UIScreen mainScreen].bounds.size.width - 50) / 4;
    CGSize size = CGSizeMake(kwidth - 0.1, kwidth - 0.1);
    
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HNImageViewController *imageVC = [[HNImageViewController alloc] init];
    imageVC.urls = _dataArr;
    imageVC.indexPath = indexPath;
    [self.navigationController pushViewController:imageVC animated:YES];
    
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
