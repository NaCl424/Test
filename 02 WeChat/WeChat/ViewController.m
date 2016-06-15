//
//  ViewController.m
//  WeChat
//
//  Created by JayWon on 15/10/7.
//  Copyright (c) 2015年 JayWon. All rights reserved.
//

#import "ViewController.h"
#import "XMPPManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation ViewController

/*

 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (IBAction)loginAction:(id)sender {
    NSString *user = self.usernameTF.text;
    NSString *pass = self.pwdTF.text;
    
    if (user.length == 0 || pass.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名密码不能为空" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    [[XMPPManager sharedManager] loginWithUsername:user password:pass loginSuccess:^{
        
        //登录成功的跳转
        UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"kUserListViewCtrl"];
        
        [UIView transitionWithView:self.view.window
                          duration:.4
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            self.view.window.rootViewController = nav;
                        }
                        completion:NULL];
        
    } loginFail:^(NSString *error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败"
                                                        message:error
                                                       delegate:nil
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
 
}

- (IBAction)registerAction:(id)sender {
    NSString *user = self.usernameTF.text;
    NSString *pass = self.pwdTF.text;
    
    if (user.length == 0 || pass.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名密码不能为空" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }

    //注册成功的跳转
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"kUserListViewCtrl"];
    
    [UIView transitionWithView:self.view.window
                      duration:.4
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        self.view.window.rootViewController = nav;
                    }
                    completion:NULL];

}

@end
