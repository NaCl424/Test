//
//  Author.m
//  AfterTaste
//
//  Created by 林林 on 16/6/30.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "Author.h"

@implementation Author

+ (instancetype)authorWithDictionary:(NSDictionary *)dic {
    
    Author *author = [[Author alloc] init];
    if (author) {
        
        author.uname = dic[@"uname"];
        author.header = dic[@"header"];
        author.level = [NSString stringWithFormat:@"LV%@", dic[@"level"]];
    }
    return author;
}

@end
