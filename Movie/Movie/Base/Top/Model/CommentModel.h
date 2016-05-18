//
//  CommentModel.h
//  Movie
//
//  Created by 林林 on 16/5/15.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic, copy) NSString *userImage;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *content;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
