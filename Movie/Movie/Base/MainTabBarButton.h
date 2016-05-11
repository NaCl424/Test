//
//  MainTabBarButton.h
//  Movie
//
//  Created by 林林 on 16/5/10.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarButton : UIButton

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UILabel *title;

+(instancetype)mainTabBarButtonWithImage:(UIImage *)image title:(NSString *)title frame:(CGRect)frame;

@end
