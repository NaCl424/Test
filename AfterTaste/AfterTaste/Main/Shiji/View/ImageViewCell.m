//
//  ImageViewCell.m
//  AfterTaste
//
//  Created by 林林 on 16/7/5.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "ImageViewCell.h"

@implementation ImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNoteImage:(UIImage *)noteImage {
    
    if (_noteImage == noteImage) {
        return;
    }
    _noteImage = noteImage;
    self.noteImageView.image = _noteImage;
}

@end
