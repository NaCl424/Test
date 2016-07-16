//
//  CityList.h
//  AfterTaste
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityList : NSObject

@property (nonatomic, strong)NSString *name;

@property (nonatomic, assign)BOOL isDisplay;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)NSString *urlString;


@end
