//
//  News.h
//  Movie
//
//  Created by 林林 on 16/5/13.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

typedef enum {
    NewsTypeNone = 0,
    NewsTypeImage = 1,
    NewsTypeVedio = 2,
}NewsType;

/*
 "newsid" : 1491552,
 "type" : 1,
 "image" : "http://img31.mtime.cn/mg/2012/06/28/112005.28198250.jpg",
 "title" : "《小律师有大作为》宣传海报",
 "summary" : "小律师有大作为,TNT,律政剧"
 */

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) NewsType type;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
