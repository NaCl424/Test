//
//  HNImageViewController.m
//  图片浏览
//
//  Created by 林林 on 16/5/16.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import "HNImageViewController.h"
#import "HNBigImageCollectionView.h"
#import "HNImageCell.h"

@interface HNImageViewController ()
{
    BOOL _isNavHiden;
    HNBigImageCollectionView *imageColletion;
}

@end

@implementation HNImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isNavHiden = NO;
    //添加隐藏导航栏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidenAction) name:KHidenNotification object:nil];
    
    imageColletion = [[HNBigImageCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    imageColletion.urls = _urls;
    [self.view addSubview:imageColletion];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)hidenAction {
    
    _isNavHiden = !_isNavHiden;
    [self.navigationController setNavigationBarHidden:_isNavHiden animated:YES];
    
}
//滚动到当前要显示的图片
- (void)viewWillAppear:(BOOL)animated {
    
    [imageColletion scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
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
