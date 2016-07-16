//
//  RecommendCell1.m
//  AfterTaste
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "RecommendCell1.h"
#import "CorCViewController.h"
#import "CityViewController.h"

@interface RecommendCell1 ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
    NSMutableArray *_countryOrCityArray;
}
@end

@implementation RecommendCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setArray:(NSArray *)array {
    if (_array == array) {
        return;
    }
    _array = array;
    _countryOrCityArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _array.count; i++) {

        NSDictionary *dic = array[i];
        if (i < 3) {

            Country *country = [[Country alloc] init];
            country.name = dic[@"name"];
            country.imageName = dic[@"cover"];
            [_countryOrCityArray addObject:country];
        }else {

            City *city = [[City alloc] init];
            city.name = dic[@"name"];
            city.imageName = dic[@"cover"];
            [_countryOrCityArray addObject:city];
        }
    }

    [self createSubviews];
}
- (void)createSubviews {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    flowLayout.itemSize = CGSizeMake(kItemWidth, kItemWidth + 20);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, kCollectionViewSpace, 5, kCollectionViewSpace);
    flowLayout.minimumInteritemSpacing = kItemSpace;
    flowLayout.minimumLineSpacing = 0;


    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kCollectionViewSpace, kScreenWidth, 2*(kItemWidth + kCollectionViewSpace + 20)) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}
//单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _countryOrCityArray.count;
}
//单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kItemWidth)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, 20)];
    label.top = imageView.bottom;
    label.textAlignment = NSTextAlignmentCenter;

    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:label];
    if (_countryOrCityArray == nil) {
        return nil;
    }
    if (indexPath.item < 3) {

        Country *country = _countryOrCityArray[indexPath.item];

        [imageView sd_setImageWithURL:[NSURL URLWithString:country.imageName]];
        label.text = country.name;
    }else {

        City *city = _countryOrCityArray[indexPath.item];
        [imageView sd_setImageWithURL:[NSURL URLWithString:city.imageName]];
        label.text = city.name;
        
    }
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.text = nil;
        }
    }
}
//选中单元格
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.item < 3) {

        Country *country = _countryOrCityArray[indexPath.item];
        country.index = indexPath.item % 3;
        //        [country countryRequestWithContinentIndex:_continent.index];
        [country loadJsonFileWithContinentIndex:indexPath.item];

        CorCViewController *vc = [[CorCViewController alloc] init];
        vc.country = country;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{

        CityViewController *vc = [[CityViewController alloc] init];
        City *city = _countryOrCityArray[indexPath.item];
        city.index = indexPath.item % 4;
//        [city cityRequestWithCountryIndex:indexPath.item % 3];
        [city loadJsonFileWithCountryIndex:indexPath.item % 3];

        vc.city = city;
        vc.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}
//使用响应者链获取导航控制器
- (UINavigationController *)navigationController {

    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)nextResponder;
        }
        nextResponder = nextResponder.nextResponder;
    }

    return nil;
}@end
