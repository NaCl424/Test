//
//  MoviePostCollectionCell.h
//  Movie
//
//  Created by 林林 on 16/5/17.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MoviePostCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *postDetail;
@property (weak, nonatomic) IBOutlet UIImageView *moviePostImage;
@property (strong, nonatomic) Movie *movie;

@end
