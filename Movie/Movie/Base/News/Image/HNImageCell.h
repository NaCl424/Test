//
//  HNImageCell.h
//  图片浏览
//
//  Created by 林林 on 16/5/16.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KHidenNotification @"KHidenNotification"

@interface HNImageCell : UICollectionViewCell <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSURL *url;

- (void)backToOneScale;

@end
