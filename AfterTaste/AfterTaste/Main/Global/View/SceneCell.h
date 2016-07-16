//
//  SceneCell.h
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *sceneImageView;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *count;

@property (nonatomic, strong)Scene *scene;
@end
