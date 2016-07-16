//
//  SceneCell.m
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "SceneCell.h"

@implementation SceneCell

- (void)setScene:(Scene *)scene {
    if (_scene == scene) {
        return;
    }
    _scene = scene;
    _name.text = _scene.name;
    [_sceneImageView sd_setImageWithURL:[NSURL URLWithString:_scene.imageName]];
    _count.text = [NSString stringWithFormat:@"%@家餐厅", _scene.num];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
