//
//  MoviePostCollectionView.h
//  Movie
//
//  Created by 林林 on 16/5/17.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviePostCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger currentIndex;

@end
