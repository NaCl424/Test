//
//  MapRestCollectionView.h
//  BDMAP
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "MapRestCollectionView.h"
#import "RestCollectionCell.h"
#import "Restaurant.h"
@implementation MapRestCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame withItemSize:(CGSize)size{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    _itemSize = size;
    layout.itemSize = size;
    //设置单元格间隙,为单元格宽度的30分之一
    layout.minimumLineSpacing = size.width/30.0 ;
    _pageWidth = _itemSize.width + layout.minimumLineSpacing;
    //设置边缘间隙,使滑动到最左边与最右边时的两个cell,居中显示
    CGFloat edge = frame.size.width/2 - size.width/2;
    layout.sectionInset = UIEdgeInsetsMake(5, edge, 5, edge);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
        //隐藏滑动条
        
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        //注册cell
        [self registerNib:[UINib nibWithNibName:@"RestCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"restCollCell"];
        
    }
    
    return self;
    
}


#pragma mark - collectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return _restList.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RestCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"restCollCell" forIndexPath:indexPath];
    cell.restModel = [[Restaurant alloc] initWithJsonName:_restList[indexPath.row]];
    
    
    
    return cell;
}

//滑到某一页
- (void)scrollToItemAtIndex:(NSUInteger)index{

    
    if (index >= _restList.count) {
        
        return;
    }
    
    [self setContentOffset:CGPointMake(_pageWidth  * index , 0) animated:YES];

}

//targetContentOffset目标偏移量
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    //获取当前滑动偏移量
    CGFloat x = scrollView.contentOffset.x;
    //一张图片的宽度加 左边间隙
   // CGFloat width = _itemSize.width * (1 + 1/30.0);
    
    //计算应该显示的页面
    /*页码与x关系
     页码 :        x
     0  :   (0 - 0.5)width
     1  :   (0.5--1.5)width
     2  :   (1.5--2.5)width
     */
    NSUInteger page = x / _pageWidth + 0.5;
    
    //设置偏移量
    targetContentOffset->x = page * _pageWidth;
    
    //设置currentIndexPath
    
    self.currentIndex = page;
    
}

//设置页码时
- (void)setCurrentIndex:(NSUInteger)currentIndex {

    if (_currentIndex == currentIndex) {
        
        return;
    }
    _currentIndex = currentIndex;
    
    if (_indexChangedBlock) {
        
        _indexChangedBlock(_currentIndex);
    }

}

- (void)setRestList:(NSArray *)restList {

    
    if (_restList == restList) {
        
        return;
    }
    
    _restList = restList;
    [self reloadData];

}



@end
