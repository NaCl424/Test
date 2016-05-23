//
//  SmallPostCollectionView.m
//  Movie
//
//  Created by 林林 on 16/5/18.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "SmallPostCollectionView.h"
#import "Movie.h"
#import "SmallPostCell.h"

@interface SmallPostCollectionView ()
{
    
    NSMutableArray *_movies;
}
@end

@implementation SmallPostCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemHeight = frame.size.height;
    layout.itemSize = CGSizeMake(itemHeight / 1.6, itemHeight);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 5;
    //两边宽度
    CGFloat width = (frame.size.width - layout.itemSize.width) / 2;
    layout.sectionInset = UIEdgeInsetsMake(0, width, 0, width);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
        self.showsHorizontalScrollIndicator = NO;
        
        self.backgroundColor = [UIColor clearColor];
        //注册单元格
        UINib *nib = [UINib nibWithNibName:@"SmallPostCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellWithReuseIdentifier:@"SmallPostCell"];
        //加载数据
        NSDictionary *data = [JSONDataService loadJsonFileWithName:@"us_box"];
        _movies = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in data[@"subjects"]) {
            Movie *m = [[Movie alloc] initWithDictionary:dict];
            [_movies addObject:m];
        }
        
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SmallPostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SmallPostCell" forIndexPath:indexPath];
    [cell setMovie:_movies[indexPath.item]];
    
    return cell;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    //    NSLog(@"x = %f, y = %f", targetContentOffset->x, targetContentOffset->y);
    //获取滑动结束后的偏移量
    CGFloat xOffset = targetContentOffset->x;
    CGFloat width = (self.frame.size.height) / 1.6 + 10;
    CGFloat floatIndex = xOffset / width;
    NSInteger integerIndex = floatIndex + 0.5;
    self.currentIndex = integerIndex;
    //根据页码计算偏移量
    CGFloat targetXOffset = integerIndex * width;
    
    //设定最后所在位置
    targetContentOffset->x = targetXOffset;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取点击的单元格编号
    CGFloat xOffset = collectionView.contentOffset.x;
    CGFloat width = (self.frame.size.height - 84) / 1.7 + 20;
    CGFloat floatIndex = xOffset / width;
    NSInteger integerIndex = floatIndex + 0.5;
    //进行判断是中间单元格还是两边的
    if (integerIndex == indexPath.item) {
        //获取单元格
//        SmallPostCell *cell = (SmallPostCell *)[collectionView cellForItemAtIndexPath:indexPath];
    }else {
        //点击两边单元格，移到中间
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.currentIndex = indexPath.item;
    }
    
    
}

@end
