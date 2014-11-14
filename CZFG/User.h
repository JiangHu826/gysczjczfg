//
//  User.h
//  CZFG
//
//  Created by lihong on 14/11/11.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "ModelParser.h"

@interface User : ModelParser
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *number;
// 0为正常登录 1为锁定 2为欠费 3为用户名密码错误
@property (nonatomic, copy) NSString *loginResult;
@end
