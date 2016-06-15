//
//  XMPPManager.h
//  WeChat
//
//  Created by kangkathy on 15/11/30.
//  Copyright © 2015年 JayWon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"

#define kHostName @"wxhl"
#define kHostIP @"192.168.0.98"
#define kHostPort 5222
#define kReceiveMessageNotificationName @"kReceiveMessageNotificationName"
//登录成功
typedef void(^XMPPMLoginSuccessBlock)(void);
//登录失败
typedef void(^XMPPMLoginFailBlock)(NSString *);

//注册成功
typedef void(^XMPPMRegisterSuccessBlock)(void);
//注册失败
typedef void(^XMPPMRegisterFailBlock)(NSString *);

//好友列表
typedef void(^XMPPMFriendsListBlock)(id result);

@interface XMPPManager : NSObject
{
    XMPPStream *_xmppStream;
    XMPPRoster *_xmppRoster;
}

//单例
+ (instancetype)sharedManager;

//登录
- (void)loginWithUsername:(NSString *)username password:(NSString *)password loginSuccess:(XMPPMLoginSuccessBlock)sBlock loginFail:(XMPPMLoginFailBlock)fBlock;

//登录
- (void)registerWithUsername:(NSString *)username password:(NSString *)password loginSuccess:(XMPPMRegisterSuccessBlock)sBlock loginFail:(XMPPMRegisterFailBlock)fBlock;

//下线
- (void)goOffline;

//好友列表
- (void)setFriendsListBlock:(XMPPMFriendsListBlock)block;

//发送消息
- (void)sendMessage:(NSString *)text toUser:(NSString *)jid;

@end





