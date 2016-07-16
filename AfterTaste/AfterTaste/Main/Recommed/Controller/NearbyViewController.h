//
//  NearbyViewController.h
//  AfterTaste
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopToolScrollView.h"

@interface NearbyViewController : UIViewController

@property(nonatomic, strong)TopToolScrollView *topToolView;
@property(nonatomic , copy)NSDictionary *response;

@end
