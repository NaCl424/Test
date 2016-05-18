//
//  CommentCell.h
//  Movie
//
//  Created by 林林 on 16/5/15.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIView *commentBackView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) CommentModel *commentModel;


@end
