//
//  XMPPManager.m
//  WeChat
//
//  Created by kangkathy on 15/11/30.
//  Copyright © 2015年 JayWon. All rights reserved.
//
/*
 1-->先创建一个XMPP的单例对象--在把所有的XMPP对象及方法进行封装--方便在程序各个地方都可以用
 2-->登录--获取登录对象的（id）
 3-->获取好友列表
 4-->显示聊天的信息
 5-->注销功能
 
 
 */
#import "XMPPManager.h"
#import "User.h"
@class User;

typedef enum{
    
    XMPPManagerLoginConnect,
    XMPPManagerRegisterConnect
    
}XMPPManagerConnectType;

@interface XMPPManager () <XMPPStreamDelegate, XMPPRosterDelegate>
{
    NSString *_username;
    NSString *_password;
    
    XMPPMLoginSuccessBlock _loginSucessBlock;
    XMPPMLoginFailBlock _loginFailBlock;
    
    XMPPMRegisterSuccessBlock _registerSuccessBlock;
    XMPPMRegisterFailBlock _registerFailBlock;
    
    XMPPMFriendsListBlock _friendsListBlock;
    
    //连接类型
    XMPPManagerConnectType _connectType;
}
@end

@implementation XMPPManager

#pragma mark 单例
+ (instancetype)sharedManager {
    
    static XMPPManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[super allocWithZone:nil] init];
            //初始化
            [manager setupXMPPManager];
        }
    });
    
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedManager];
}

- (id)copy {
    return self;
}

#pragma mark 初始化
//初始化设置XMPPManager
- (void)setupXMPPManager {
    
    //1 创建XMPPStream
    _xmppStream = [[XMPPStream alloc] init];
    
    //2 设置重连接对象
    XMPPReconnect *reconnect = [[XMPPReconnect alloc] init];
    //绑定
    [reconnect activate:_xmppStream];
    
    //3 设置花名册(好友列表)
    XMPPRosterCoreDataStorage *storage = [[XMPPRosterCoreDataStorage alloc] init];
    _xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:storage];
    //绑定
    [_xmppRoster activate:_xmppStream];
    
    //4 设置主机域名和端口号
    [_xmppStream setHostName:kHostName];
    [_xmppStream setHostPort:kHostPort];
    
    //5 设置代理对象,用于接收网络数据
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [_xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

#pragma mark - 登录
- (void)loginWithUsername:(NSString *)username password:(NSString *)password loginSuccess:(XMPPMLoginSuccessBlock)sBlock loginFail:(XMPPMLoginFailBlock)fBlock {
    
    //保存数据
    _username = username;
    _password = password;
    
    //保存block
    _loginSucessBlock = [sBlock copy];
    _loginFailBlock = [fBlock copy];
    
    _connectType = XMPPManagerLoginConnect;
    //连接操作
    BOOL isConnect = [self connect];
    if (!isConnect) {
        //连接失败,回调block
        if (_loginFailBlock) {
            _loginFailBlock(@"服务器无响应");
        }
    }
}

#pragma mark - 注册
- (void)registerWithUsername:(NSString *)username password:(NSString *)password loginSuccess:(XMPPMRegisterSuccessBlock)sBlock loginFail:(XMPPMRegisterFailBlock)fBlock {
    
    //保存数据
    _username = username;
    _password = password;
    
    //保存block
    _registerSuccessBlock = [sBlock copy];
    _registerFailBlock = [fBlock copy];
    
    _connectType = XMPPManagerRegisterConnect;
    //连接操作
    BOOL isConnect = [self connect];
    if (!isConnect) {
        //连接失败,回调block
        if (_registerFailBlock) {
            _registerFailBlock(@"服务器无响应");
        }
    }
}


#pragma mark - 连接
- (BOOL)connect {
    
    //拼接JID
    NSString *jidString = [NSString stringWithFormat:@"%@@%@", _username, kHostName];
    //设置JID
    XMPPJID *jid = [XMPPJID jidWithString:jidString];
    
    //开启连接
    _xmppStream.myJID = jid;
    //连接服务器,并返回连接结果
    return [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:nil];
    
}


#pragma mark - 上线 下线
- (void)goOnline {
    
    //创建一个用户状态
    XMPPPresence *presence = [[XMPPPresence alloc] initWithType:@"available"];
    //想服务器提交状态
    [_xmppStream sendElement:presence];
    
}

- (void)goOffline {
    
    //创建一个用户状态
    XMPPPresence *presence = [[XMPPPresence alloc] initWithType:@"unavailable"];
    //想服务器提交状态
    [_xmppStream sendElement:presence];
    [_xmppStream disconnect];
    NSLog(@"下线成功");
}

#pragma mark - 好友列表
- (void)setFriendsListBlock:(XMPPMFriendsListBlock)block {
    
    //保存block
    _friendsListBlock = block;
    
    //创建IQ请求
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    //设置IQ请求属性
    XMPPJID *jid = _xmppStream.myJID;
    [iq addAttributeWithName:@"from" stringValue:jid.description];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addAttributeWithName:@"id" stringValue:@"roster_1"];
    
    XMPPElement *query = [XMPPElement elementWithName:@"query"];
    [query addAttributeWithName:@"xmlns" stringValue:@"jabber:iq:roster"];
    //添加子节点
    [iq addChild:query];
    
    //发送查询请求
    [_xmppStream sendElement:iq];
}

#pragma mark - XMPP Delegate
//连接上服务器
- (void)xmppStreamDidConnect:(XMPPStream *)sender {
    
    NSLog(@"连接成功");
    //判断连接类型
    if (_connectType == XMPPManagerLoginConnect) {
        
        //连接成功,开始密码认证
        [_xmppStream authenticateWithPassword:_password error:nil];
    }else if (_connectType == XMPPManagerRegisterConnect) {
        
        //连接成功,开始注册
        [_xmppStream registerWithPassword:_password error:nil];
    }
}
//认证成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
    
    if (_loginSucessBlock) {
        _loginSucessBlock();
    }
    
}
//认证失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error {
    
    //如果验证失败则断开连接
    [_xmppStream disconnect];
    if (_loginFailBlock) {
        _loginFailBlock(@"账号或者密码错误");
    }
}

//注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender {
    
    NSLog(@"注册成功");
    _loginSucessBlock = _registerSuccessBlock;
    //认证
    [_xmppStream authenticateWithPassword:_password error:nil];
}

//注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error {
    
    //如果注册失败则断开连接
    [_xmppStream disconnect];
    if (_registerFailBlock) {
        _registerFailBlock(@"账号已存在");
    }
}

//查询请求的回调
- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq {
    
    //    NSLog(@"收到好友列表查询请求:%@", iq);
    //通过id判断哪一次请求是手动请求到的
    if ([iq.elementID isEqualToString:@"roster_1"]) {
        
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
        //获取子节点
        NSXMLElement *query = [iq childElement];
        //遍历item,获取每一个用户
        for (NSXMLElement *item in query.children) {
            //创建User对象
            User *user = [[User alloc] init];
            user.jid = [item attributeStringValueForName:@"jid"];
            user.username = [item attributeStringValueForName:@"name"];
            
            //获取分组
            for (NSXMLElement *group in item.children) {
                //获取分组名
                NSString *groupName = [group stringValue];
                //从字典中获取可变数组
                NSMutableArray *groupArray = mDic[groupName];
                if (groupArray == nil) {
                    groupArray = [[NSMutableArray alloc] init];
                    [mDic setObject:groupArray forKey:groupName];
                }
                //将用户添加到数组中
                [groupArray addObject:user];
            }
        }
        if (_friendsListBlock) {
            _friendsListBlock([mDic copy]);
        }
        
    }
    
    return YES;
}

#pragma mark - 发送消息
//发送消息
- (void)sendMessage:(NSString *)text toUser:(NSString *)jid {
    
    if (text == nil || text.length == 0 || jid == nil || jid.length == 0) {
        return;
    }
    //检查jid格式
    NSRange range = [jid rangeOfString:[NSString stringWithFormat:@"@%@", kHostName]];
    if (range.location == NSNotFound) {
        return;
    }
    
    //---------------------------------方式一 XMPP自带message-------------------------------------
//    //创建消息
//    XMPPJID *toJid = [XMPPJID jidWithString:jid];
//    XMPPMessage *message = [[XMPPMessage alloc] initWithType:@"chat" to:toJid];
//    [message addBody:text];
//    //发送消息
//    [_xmppStream sendElement:message];
    
    //---------------------------------方式二 手动拼接XML-----------------------------------------
    //创建节点
    NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
    //添加属性
    XMPPJID *myJID = _xmppStream.myJID;
    [message addAttributeWithName:@"from" stringValue:myJID.description];
    [message addAttributeWithName:@"to" stringValue:jid];
    [message addAttributeWithName:@"type" stringValue:@"chat"];
    
    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    body.stringValue = text;
    //添加子节点
    [message addChild:body];
    //发送消息
    [_xmppStream sendElement:message];
    
    
}

#pragma mark - 消息的接收
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message {
    
    //判断消息的有效性
    if (message.isChatMessageWithBody) {
        
        //获取数据
        NSString *body = message.body;
        NSString *fromUserName = message.from.user;
        
        //通知的参数字典
        NSDictionary *userInfo = @{@"user" : fromUserName,
                                   @"body" : body};
        //当接收消息时发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kReceiveMessageNotificationName object:nil userInfo:userInfo];
    }
}


@end












