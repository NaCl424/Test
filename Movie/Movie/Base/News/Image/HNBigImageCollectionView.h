//
//  HNBigImageCollectionView.h
//  图片浏览
//
//  Created by 林林 on 16/5/16.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BlackWidth 30

@interface HNBigImageCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSArray *urls;

@end
