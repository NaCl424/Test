//
//  MoviePostCollectionView.m
//  Movie
//
//  Created by 林林 on 16/5/17.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "MoviePostCollectionView.h"
#import "MoviePostCollectionCell.h"
#import "Movie.h"

@interface MoviePostCollectionView ()
{
    NSMutableArray *_movies;
}
@end

@implementation MoviePostCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    //创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //大小
    CGFloat itemHeight = frame.size.height-84;
    layout.itemSize = CGSizeMake(itemHeight / 1.7, itemHeight);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 10;
    //左右间隙计算
    CGFloat width = (frame.size.width - layout.itemSize.width) / 2;
    //四周间距
    layout.sectionInset = UIEdgeInsetsMake(10, width, 10, width);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        //设置代理
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor orangeColor];
        //注册单元格
        UINib *nib = [UINib nibWithNibName:@"MoviePostCollectionCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellWithReuseIdentifier:@"MoviePostCollectionCell"];
        
        
        self.showsHorizontalScrollIndicator = NO;
        
        //加载数据
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
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MoviePostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MoviePostCollectionCell" forIndexPath:indexPath];
    [cell setMovie:_movies[indexPath.item]];
    
    return cell;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
//    NSLog(@"x = %f, y = %f", targetContentOffset->x, targetContentOffset->y);
    //获取滑动结束后的偏移量
    CGFloat xOffset = targetContentOffset->x;
    CGFloat width = (self.frame.size.height - 84) / 1.7 + 20;
    CGFloat floatIndex = xOffset / width;
    NSInteger integerIndex = floatIndex + 0.5;
    
    //根据页码计算偏移量
    CGFloat targetXOffset = integerIndex * width;
    
    //设定最后所在位置
    targetContentOffset->x = targetXOffset;
    
}


@end









