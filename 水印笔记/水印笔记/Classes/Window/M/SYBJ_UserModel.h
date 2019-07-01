//
//  SYBJ_UserModel.h
//  水印笔记
//
//  Created by linlin dang on 2019/6/21.
//  Copyright © 2019 TT. All rights reserved.
//

#import "Tool_FMDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYBJ_UserModel : Tool_FMDBModel
/// 用户ID
@property (nonatomic , assign) NSInteger user_Id;
/// 用户名
@property (nonatomic , copy) NSString *user_Name;
/// 用户账号
@property (nonatomic , copy) NSString *user_Account;
/// 用户头像
@property (nonatomic , copy) UIImage *user_HeaderIMG;
/// 用户密码
@property (nonatomic , copy) NSString *user_Password;

@end

NS_ASSUME_NONNULL_END
