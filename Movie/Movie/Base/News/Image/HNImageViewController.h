//
//  HNImageViewController.h
//  图片浏览
//
//  Created by 林林 on 16/5/16.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNImageViewController : UIViewController

@property (nonatomic, copy) NSArray *urls;
@property (nonatomic, strong) NSIndexPath *indexPath; //当前要显示的图片索引

@end
