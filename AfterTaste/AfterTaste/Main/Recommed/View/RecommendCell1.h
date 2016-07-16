//
//  RecommendCell1.h
//  AfterTaste
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kCollectionViewSpace 10
#define kItemSpace 10
#define kItemWidth (kScreenWidth - 2 * (kCollectionViewSpace + kItemSpace)) / 3

@interface RecommendCell1 : UITableViewCell

@property (nonatomic, copy)NSArray *array;

@end
