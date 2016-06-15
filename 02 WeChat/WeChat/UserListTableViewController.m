//
//  UserListTableViewController.m
//  WeChat
//
//  Created by JayWon on 15/10/7.
//  Copyright (c) 2015年 JayWon. All rights reserved.
//

#import "UserListTableViewController.h"
#import "MessageViewController.h"
#import "XMPPManager.h"
@class XMPPManager;
@interface UserListTableViewController ()
{
    BOOL status[20];    //每个section的展开\收起状态标识
}

@property(nonatomic, strong)NSDictionary *dic;

@end

@implementation UserListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //测试数据源
//    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
//    NSMutableArray *mArr1 = [[NSMutableArray alloc] init];
//    NSMutableArray *mArr2 = [[NSMutableArray alloc] init];
//    [mDic setObject:mArr1 forKey:@"好友"];
//    [mDic setObject:mArr2 forKey:@"联系人列表"];
//
//    for (int i=0; i<10; i++) {
//        User *user = [[User alloc] init];
//        user.jid = [NSString stringWithFormat:@"row:%d", i];
//        user.username = [NSString stringWithFormat:@"row:%d", i];
//        
//        if (i<5) {
//            [mArr1 addObject:user];
//        }else{
//            [mArr2 addObject:user];
//        }
//    }
//    
//    self.dic = mDic;
    
    [self getFriendsList];
}

- (void)getFriendsList {
    
    XMPPManager *manager = [XMPPManager sharedManager];
    [manager setFriendsListBlock:^(id result) {
        
        _dic = result;
        [self.tableView reloadData];
    }];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (IBAction)logoutAction:(id)sender {
    
    [[XMPPManager sharedManager] goOffline];
    
    [UIView transitionWithView:self.view.window
                      duration:.4
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        self.view.window.rootViewController = [self.storyboard instantiateInitialViewController];
                    }
                    completion:NULL];
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    NSInteger section = tap.view.tag - 200;
    
    status[section] = !status[section];
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (status[section]) {
        return 0;
    }
    
    NSString *groupKey = [_dic allKeys][section];
    NSArray *userArr = _dic[groupKey];
    return [userArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kUserListCellID" forIndexPath:indexPath];
    
    NSString *groupKey = [_dic allKeys][indexPath.section];
    NSArray *allUserArr = _dic[groupKey];
    User *user = allUserArr[indexPath.row];
    
    cell.textLabel.text = user.jid;
    cell.detailTextLabel.text = user.username;
    
    [cell layoutIfNeeded];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *kCellHeaderViewID  = @"kUITableViewHeaderFooterViewID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kCellHeaderViewID];
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kCellHeaderViewID];
        headerView.textLabel.font = [UIFont boldSystemFontOfSize:16];
        headerView.textLabel.textColor = [UIColor colorWithRed:0.210 green:0.538 blue:1.000 alpha:1.000];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [headerView addGestureRecognizer:tap];
    }
    
    headerView.textLabel.text = [_dic allKeys][section];
    
    headerView.tag = 200+section;
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *groupKey = [_dic allKeys][indexPath.section];
    NSArray *allUserArr = _dic[groupKey];
    User *user = allUserArr[indexPath.row];
    
    MessageViewController *msgViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"kChatMsgViewCtrl"];
    [self.navigationController pushViewController:msgViewCtrl animated:YES];
    msgViewCtrl.toUser = user;
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
