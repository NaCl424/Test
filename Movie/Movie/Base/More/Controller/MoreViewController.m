//
//  MoreViewController.m
//  Movie
//
//  Created by 林林 on 16/5/10.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "MoreViewController.h"
#define kCacheFilePath [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]

@interface MoreViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    
    NSString *cacheFilePath = kCacheFilePath;
    long long fileSize = [self sizeOfCacheFileInPath:cacheFilePath];
    //文件大小
    CGFloat fileSizeWithKB = fileSize / 1024;
    if (fileSizeWithKB >= 1024) {
        _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB", fileSizeWithKB / 1024];
    }else {
        _cacheLabel.text = [NSString stringWithFormat:@"%.2fKB", fileSizeWithKB];
    }
    
}

- (long long)sizeOfCacheFileInPath:(NSString *)path {
    
    long long allFileSize = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *subFiles = [fileManager subpathsOfDirectoryAtPath:kCacheFilePath error:nil];
    for (NSString *subFilePath in subFiles) {
        //通过路径获取子文件路径
        NSString *filePath = [kCacheFilePath stringByAppendingPathComponent:subFilePath];
        //获取文件大小
        NSDictionary *dic = [fileManager attributesOfItemAtPath:filePath error:nil];
        long long subFileSize = [dic[NSFileSize] longLongValue];
        allFileSize += subFileSize;
    }

    return allFileSize;
}

- (void)clearCache {
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *subFiles = [fileManager subpathsOfDirectoryAtPath:kCacheFilePath error:nil];
    for (NSString *subFilePath in subFiles) {
        //通过路径获取子文件路径
        NSString *filePath = [kCacheFilePath stringByAppendingPathComponent:subFilePath];
        //删除清理缓存
        [fileManager removeItemAtPath:filePath error:nil];
    }
    long long fileSize = [self sizeOfCacheFileInPath:kCacheFilePath];
    //文件大小
    CGFloat fileSizeWithKB = fileSize / 1024;
    if (fileSizeWithKB >= 1024) {
        _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB", fileSizeWithKB / 1024];
    }else {
        _cacheLabel.text = [NSString stringWithFormat:@"%.2fKB", fileSizeWithKB];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"正在清理所有缓存。。。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认清理", nil];
        [alert show];
    }
}
//弹出警告是否清理缓存
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 1) {
        
        [self clearCache];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
