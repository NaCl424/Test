//
//  MapRestCollectionView.h
//  BDMAP
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置页码的block回调
typedef void (^IndexChangedBlock)(NSUInteger);

@interface MapRestCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(strong, nonatomic)NSArray *restList;
@property(assign, nonatomic)CGSize itemSize;
@property(assign, nonatomic)NSUInteger currentIndex;
@property(assign, nonatomic)CGFloat pageWidth;

@property(copy, nonatomic)IndexChangedBlock indexChangedBlock;

- (instancetype)initWithFrame:(CGRect)frame withItemSize:(CGSize)size;
- (void)scrollToItemAtIndex:(NSUInteger)index;

@end


