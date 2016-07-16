//
//  RestListCollectionView.h
//  AfterTaste
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChangePageBlock)(NSUInteger);
@interface RestListCollectionView : UICollectionView  <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property(nonatomic, copy)NSArray *dataArr;
@property(nonatomic, assign)BOOL isMap;
@property(nonatomic, copy)ChangePageBlock changePageBlock;
@property(nonatomic, assign)NSUInteger mapPage;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout dataArray:(NSArray *)array;

@end
