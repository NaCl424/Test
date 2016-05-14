//
//  TopModel.h
//  Movie
//
//  Created by 林林 on 16/5/13.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface TopModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat rating;
@property (nonatomic, strong) NSDictionary *images;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
