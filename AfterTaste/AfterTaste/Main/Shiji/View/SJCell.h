//
//  SJCell.h
//  AfterTaste
//
//  Created by 林林 on 16/6/30.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJCellModel.h"

@interface SJCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UIImageView *cityIcon;
@property (weak, nonatomic) IBOutlet UIImageView *unameIcon;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel;
@property (weak, nonatomic) IBOutlet UILabel *favLabel;
@property (weak, nonatomic) IBOutlet UILabel *unameLabel;
@property (nonatomic, strong) UIImageView *timeImageView;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) SJCellModel *sjCellModel;

@end
