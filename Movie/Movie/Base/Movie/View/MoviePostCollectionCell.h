//
//  MoviePostCollectionCell.h
//  Movie
//
//  Created by 林林 on 16/5/17.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "RatingView.h"

@interface MoviePostCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *postDetail;
@property (weak, nonatomic) IBOutlet UIImageView *moviePostImage;
@property (strong, nonatomic) Movie *movie;

@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet RatingView *ratingImage;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;



- (void)flipView;
//恢复
- (void)restore;
@end
