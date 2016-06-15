//
//  MessageViewController.h
//  WeChat
//
//  Created by JayWon on 15/10/8.
//  Copyright (c) 2015年 JayWon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface MessageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, strong)User *toUser;

@end
