//
//  SmallPostCell.h
//  Movie
//
//  Created by 林林 on 16/5/18.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface SmallPostCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *smallPostImage;
@property (strong, nonatomic) Movie *movie;

@end
