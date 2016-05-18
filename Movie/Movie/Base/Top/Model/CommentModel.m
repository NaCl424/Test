//
//  CommentModel.m
//  Movie
//
//  Created by 林林 on 16/5/15.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        //数据
        self.userImage = dictionary[@"userImage"];
        self.nickname = dictionary[@"nickname"];
        self.rating = dictionary[@"rating"];
        self.content = dictionary[@"content"];
    }
    return self;
}

@end
