//
//  HNBigImageCollectionView.m
//  图片浏览
//
//  Created by 林林 on 16/5/16.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "HNBigImageCollectionView.h"
#import "HNImageCell.h"

@implementation HNBigImageCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    //创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = frame.size;
    CGRect rect = frame;
    rect.size.height -= 64;
    layout.itemSize = rect.size;
    layout.minimumLineSpacing = BlackWidth;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, BlackWidth);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //初始化
    frame.size.width += BlackWidth;
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        //设置代理
        self.dataSource = self;
        //设置分页
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        //注册单元格
        [self registerClass:[HNImageCell class] forCellWithReuseIdentifier:@"cell"];
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _urls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HNImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setUrl:_urls[indexPath.item]];
    //还原单元格大小
    [cell backToOneScale];
    
    return cell;
    
}

@end







