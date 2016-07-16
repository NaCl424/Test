//
//  SettingTableVC.m
//  AfterTaste
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "SettingTableVC.h"

#define KCachesFilePath [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]

@interface SettingTableVC ()<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *cachesLable;

@end
@implementation SettingTableVC


- (void)viewWillAppear:(BOOL)animated {

    [UIView animateWithDuration:0.4 animations:^{

        [self.navigationController setNavigationBarHidden:NO];
    }];
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    long long cachesSize = [self sizeOfFileWithPath:filePath];

    CGFloat cachesSizeWithKB = cachesSize / 1024;

    if (cachesSizeWithKB >= 1024) {
        _cachesLable.text = [NSString stringWithFormat:@"%.2fMB", cachesSizeWithKB/1024];
    }else {
        _cachesLable.text = [NSString stringWithFormat:@"%.2fKB", cachesSizeWithKB];
    }


}
- (long long)sizeOfFileWithPath:(NSString *)path {

    long long allFileSize = 0;

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *filePathArray = [fileManager subpathsOfDirectoryAtPath:path error:nil];
    for (NSString *filePath in filePathArray) {

        NSString *subFilePath = [path stringByAppendingPathComponent:filePath];

        NSDictionary *dic = [fileManager attributesOfItemAtPath:subFilePath error:nil];

        long long subFileSize = [dic[NSFileSize] longLongValue];

        allFileSize += subFileSize;

    }

    return allFileSize;
}

- (void)clearCaches {

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSArray *filePathArray = [fileManager subpathsOfDirectoryAtPath:KCachesFilePath error:nil];
    for (NSString *filePath in filePathArray) {

        NSString *subFilePath = [KCachesFilePath stringByAppendingPathComponent:filePath];

        [fileManager removeItemAtPath:subFilePath error:nil];
    }

    long long cachesSize = [self sizeOfFileWithPath:KCachesFilePath];

    CGFloat cachesSizeWithKB = cachesSize / 1024;

    if (cachesSizeWithKB >= 1024) {
        _cachesLable.text = [NSString stringWithFormat:@"%.2fMB", cachesSizeWithKB/1024];
    }else {
        _cachesLable.text = [NSString stringWithFormat:@"%.2fKB", cachesSizeWithKB];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {


        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"即将清理缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定清理", nil];
        [alertView show];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [self clearCaches];
    }
    
}
@end
