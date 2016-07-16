//
//  RestListCollectionCell.h
//  AfterTaste
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RestListCollectionCell : UICollectionViewCell <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_listArray;
}
@property(nonatomic, copy) NSDictionary *dataDic;


@end
