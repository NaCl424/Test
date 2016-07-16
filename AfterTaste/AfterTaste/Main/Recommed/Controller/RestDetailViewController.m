//
//  RestDetailViewController.m
//  AfterTaste
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "RestDetailViewController.h"
#import "UIImageView+WebCache.h"
@interface RestDetailViewController ()

@end

@implementation RestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = _restModel.name;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = titleLabel;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth /2)];
        NSURL *imageUrl = [NSURL URLWithString:_restModel.cover];
        [image sd_setImageWithURL:imageUrl];
        return image;
    }else if (section == 2) {
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
        backView.backgroundColor = [UIColor whiteColor];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 10, 15)];
        title.text = @"推荐理由";
        [backView addSubview:title];
        
        UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth - 10, 50)];
        subTitle.text = _restModel.reason;
        subTitle.font = [UIFont systemFontOfSize:13];
        subTitle.textColor = [UIColor grayColor];
        subTitle.numberOfLines = 0;
        [backView addSubview:subTitle];
        return backView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        
        return kScreenWidth / 2;
    }else if (section == 2) {
    
        return 70;
    }
    return 0.1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        return 60;
    }else if (indexPath.section == 1) {
    
        return kScreenWidth / 3;
    }else {
    
        CGSize size = CGSizeMake(kScreenWidth, 1000);
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16]};
      CGRect rect =  [_restModel.desc boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height + 40;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 2) {
        
        return 0.1;
    }
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell ;
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"restFirstCell"];

        UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
        label.text = _restModel.address;
        
        UIButton *button = (UIButton *)[cell.contentView viewWithTag:102];
        [button addTarget:self action:@selector(locationButtonAC:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else if (indexPath.section == 1) {
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"restSecondCell" ];

        UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:201];
        label1.text = [NSString stringWithFormat:@"人均:%@元",_restModel.cost];
        
        UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:202];
        if (_restModel.open_time.length) {
            
            label2.text = [NSString stringWithFormat:@"营业时间:%@",_restModel.open_time];
        }else {
        
            label2.text = @"营业时间:暂无";
        }

        UILabel *label3 = (UILabel *)[cell.contentView viewWithTag:203];
        label3.text = [NSString stringWithFormat:@"电话:%@",_restModel.phone];

        return cell;
    }
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"restThirdCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _restModel.desc;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}


- (void)locationButtonAC:(UIButton *)button {
    
    //BaseBackViewController *mapVC = [[BaseBackViewController alloc] init];
    
    
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
