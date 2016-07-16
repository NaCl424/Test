
//
//  JSONDataService.m
//  MyMovie
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 ljp. All rights reserved.
//

#import "JSONDataService.h"

@implementation JSONDataService

+ (id)loadJSONFielWithName:(NSString *)name {


    NSRange range = [name rangeOfString:@".json"];
    if (range.location != NSNotFound) {
        name = [name substringToIndex:range.location];
    }
    NSString *fileName = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:fileName];

    if (data == nil) {
        return nil;
    }

    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

    return result;

}




@end
