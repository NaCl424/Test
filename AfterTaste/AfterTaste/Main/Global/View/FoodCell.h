//
//  FoodCell.h
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *foodImageView;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *sum;

@property (strong, nonatomic) Food *food;

@end
