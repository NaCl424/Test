//
//  CityViewController.m
//  AfterTaste
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 ljp. All rights reserved.
//

#import "CorCViewController.h"
#import "CityViewController.h"


#define kCollectionViewSpace 10
#define kItemSpace 20
#define kItemWidth (kScreenWidth - 2 * (kCollectionViewSpace + kItemSpace)) / 3
@interface CorCViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}

@end

@implementation CorCViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    if (_continent) {
        self.title = _continent.name;
    }else if (_country) {
        self.title = _country.name;
    }
    [self createCollectionView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kReloadCollectionViewNotification object:nil];
}

#pragma mark - 覆写set方法
- (void)setContinent:(Continent *)continent {
    if (_continent == continent) {
        return;
    }
    _continent = continent;
    [_collectionView reloadData];
}
- (void)setCountry:(Country *)country {
    if (_country == country) {
        return;
    }
    _country = country;
    [_collectionView reloadData];
}

#pragma mark - 创建单元格视图
- (void)createCollectionView {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    flowLayout.itemSize = CGSizeMake(kItemWidth, kItemWidth + 20);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, kCollectionViewSpace, 5, kCollectionViewSpace);
    flowLayout.minimumInteritemSpacing = kItemSpace;
    flowLayout.minimumLineSpacing = 0;


    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
}
#pragma mark - request

//单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_continent) {
        return _continent.countries.count;
    }else if (_country) {
        return _country.cities.count;
    }
    return 0;
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

    if (_continent) {

        Country *country = _continent.countries[indexPath.row];

        [imageView sd_setImageWithURL:[NSURL URLWithString:country.imageName]];
        label.text = country.name;
    }else if (_country) {

        City *city = _country.cities[indexPath.row];
        [imageView sd_setImageWithURL:[NSURL URLWithString:city.imageName]];
        label.text = city.name;

    }

    return cell;

}
//选中单元格
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (_continent) {

        Country *country = _continent.countries[indexPath.item];
        country.index = indexPath.item % 3;
//        [country countryRequestWithContinentIndex:_continent.index];
        [country loadJsonFileWithContinentIndex:_continent.index];

        CorCViewController *vc = [[CorCViewController alloc] init];
        vc.country = country;

        [self.navigationController pushViewController:vc animated:YES];
    }else if (_country) {

        CityViewController *vc = [[CityViewController alloc] init];
        City *city = _country.cities[indexPath.item];
        city.index = indexPath.item % 4;
        [city cityRequestWithCountryIndex:_country.index];
        [city loadJsonFileWithCountryIndex:_country.index];

        vc.city = city;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.text = nil;
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
