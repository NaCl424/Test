//
//  Author.h
//  AfterTaste
//
//  Created by 林林 on 16/6/30.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject

@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *level;

+ (instancetype)authorWithDictionary:(NSDictionary *)dic;

@end
