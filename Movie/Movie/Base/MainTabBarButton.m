//
//  MainTabBarButton.m
//  Movie
//
//  Created by 林林 on 16/5/10.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "MainTabBarButton.h"

@implementation MainTabBarButton

+(instancetype)mainTabBarButtonWithImage:(UIImage *)image title:(NSString *)title frame:(CGRect)frame {
    
    //创建一个基本的按钮
    MainTabBarButton *button = [MainTabBarButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    //给按钮添加图片和label
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 20)];
    imageView.center = CGPointMake(button.frame.size.width / 2, button.center.y - 5);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height * 0.7, frame.size.width, frame.size.height* 0.3)];
    
    //将子视图添加到button
    [button addSubview:imageView];
    [button addSubview:label];
    
    //label的设置
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    
    //设定实现的内容
    imageView.image = [image copy];
    label.text = title;
    
    return button;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
