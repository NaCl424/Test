//
//  JSONDataService.h
//  Movie
//
//  Created by 林林 on 16/5/13.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONDataService : NSObject

+ (id)loadJsonFileWithName:(NSString *)fileName;

@end
