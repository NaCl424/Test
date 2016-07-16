//
//  ImageViewCell.h
//  AfterTaste
//
//  Created by 林林 on 16/7/5.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *noteImageView;
@property (nonatomic, strong) UIImage *noteImage;

@end
