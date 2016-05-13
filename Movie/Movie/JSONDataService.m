//
//  JSONDataService.m
//  Movie
//
//  Created by 林林 on 16/5/13.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "JSONDataService.h"

@implementation JSONDataService

+ (id)loadJsonFileWithName:(NSString *)fileName {
    
    //判断fileName中是否有.json后缀
    if ([fileName hasSuffix:@".json"]) {
        NSRange range = [fileName rangeOfString:@".json"];
        fileName = [fileName substringToIndex:range.location];
    }
//    NSLog(@"%@", fileName);
    //读取文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    //加载数据
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //判断data数据有无加载到
    if (data == nil) {
        return nil;
    }
    //解析json
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                           options:NSJSONReadingMutableLeaves error:nil];
    return result;
}

@end
