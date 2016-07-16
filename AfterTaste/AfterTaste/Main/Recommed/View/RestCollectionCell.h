//
//  RestCollectionCell.h
//  
//
//  Created by mac on 16/7/6.
//
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
@interface RestCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *restImage;
@property (weak, nonatomic) IBOutlet UILabel *restName;
@property (weak, nonatomic) IBOutlet UILabel *restPrice;

@property (nonatomic, strong)Restaurant *restModel;

@end
