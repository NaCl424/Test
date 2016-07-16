//
//  RestListCollectionView.m
//  AfterTaste
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "RestListCollectionView.h"
#import "RestListCollectionCell.h"
#import "RestMapCollectionViewCell.h"
@implementation RestListCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout dataArray:(NSArray *)array {

    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        _dataArr = array;
        self.dataSource = self;
        self.delegate = self;
        
        //隐藏滑动条
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = YES;
        //注册cell
        
        [self registerClass:[RestListCollectionCell class] forCellWithReuseIdentifier:@"restListCell"];
        [self registerClass:[RestMapCollectionViewCell class] forCellWithReuseIdentifier:@"restMapCell"];
    }
    
    return self;


}

//设置为地图
- (void)setIsMap:(BOOL)isMap {

    if (_isMap == isMap) {
        
        return;
    }
    _isMap = isMap;
    
    [self reloadData];

}
//设置地图的页码,刷新地图
- (void)setMapPage:(NSUInteger)mapPage {
    
    if (!_isMap) {
        
        return;
    }
    if (_mapPage == mapPage) {
        
        return;
    }
    
    _mapPage = mapPage;
    
    [self reloadData];
    
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (!_isMap){
    
        return _dataArr.count;
    }else {
    
        return 1;
    }
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    if (!_isMap) {
        
        RestListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"restListCell" forIndexPath:indexPath];
        
        cell.dataDic = _dataArr[indexPath.row];
        return cell;
    }else {
    
    
        RestMapCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"restMapCell" forIndexPath:indexPath];
        
        cell.dataDic = _dataArr[_mapPage];
        return cell;
    
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (_isMap) {
        
        return;
    }
    
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 当前位置需要显示的控制器的索引  超出2个像素就加载下一页
    NSInteger index =( offsetX + scrollViewW - 2) / scrollViewW;

    
    if (_changePageBlock) {
        
        _changePageBlock(index);
    }




}



@end
