//
//  TopCell.h
//  Movie
//
//  Created by 林林 on 16/5/13.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopModel.h"
#import "RatingView.h"

@interface TopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (strong, nonatomic) TopModel *topModel;
@property (strong, nonatomic) IBOutlet RatingView *ratingView;


@end
