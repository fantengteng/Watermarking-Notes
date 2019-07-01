
//
//  SYBJ_RegisetC.m
//  水印笔记
//
//  Created by TT on 2019/6/27.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "SYBJ_RegisetC.h"
#import "SYBJ_UserModel.h"
@interface SYBJ_RegisetC ()
@property (nonatomic , strong) UILabel *message;
@property (nonatomic , strong) TT_CustonTF *login;
@property (nonatomic , strong) TT_CustonTF *password;
@property (nonatomic , strong) UIButton *login_btn;
@property (nonatomic , strong) UIButton *xieyi_btn;
@end

@implementation SYBJ_RegisetC


#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self wr_setNavBarShadowImageHidden:YES];
    [self.view addSubview:self.message];
    [self.view addSubview:self.login];
    [self.view addSubview:self.password];
    [self.view addSubview:self.login_btn];
    [self.view addSubview:self.xieyi_btn];
    
}


#pragma mark 回调协议

#pragma mark 界面跳转

#pragma mark 触发方法

- (void)tap_btn:(UIButton *)btn {
    
    switch (btn.tag) {
        case 105:
        {
            [self configRegist];
        }
            break;
        case 106:
        {
            
        }
            
        default:
            break;
    }
    
}


- (void)configRegist {
    [[FTT_HudTool share_FTT_HudTool]CreateMBProgressHUDModeIndeterminateForVeiw:self.view];
    if ([self.login.text isEqualToString:self.login.placeholder] || [self.password.text isEqualToString:self.password.placeholder] || [self.password.text isEqualToString:@""] || [self.login.text isEqualToString:@""]) {
        [[FTT_HudTool share_FTT_HudTool]dissmiss];
        [self configTextTankuangTitle:LOCALIZATION(@"请输入相应的信息")];
    }else {
        NSString *SQL = [NSString stringWithFormat:@" WHERE user_Account = '%@' ",self.login.text];
        NSArray *array = [SYBJ_UserModel findByCriteria:SQL];
        if (array.count != 0) {
            
            [[FTT_HudTool share_FTT_HudTool]dissmiss];
            [self configTextTankuangTitle:LOCALIZATION(@"账号已存在，请登录!!!")];
        }else {
            [self configLoginModel];
        }
    }
}


/// 登陆
- (void)configLoginModel {
    SYBJ_UserModel *model = [[SYBJ_UserModel alloc]init];
    model.user_Password = self.password.text;
    model.user_Name = self.login.text;
    model.user_Account = self.login.text;
    model.user_HeaderIMG = [UIImage imageNamed:@"icon-user-img"];
    if ([model save]) {
        [self configRegistSuccess:model.user_Id];
    }else {
        [self configTextTankuangTitle:LOCALIZATION(@"注册失败,请重试!!!")];
    }
}


- (void)configRegistSuccess:(NSInteger)user_id {
    NSString *userid = [NSString stringWithFormat:@"%ld",user_id];
    SaveObject(userid, @"userId");
    
    [[FTT_HudTool share_FTT_HudTool]dissmiss];
    [self configTankuangTitle:LOCALIZATION(@"注册成功") imageName:@"" Back:^{
       
        
    }];
   
    [self performSelector:@selector(JumpMain) withObject:self afterDelay:1];
}

- (void)JumpMain {
   [[SYBJ_TabBar Share_TabBarTool]SYBJ_CreateTabBar];
}


#pragma mark 公开方法


#pragma mark 私有方法

- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
}


#pragma mark 存取方法


- (UILabel *)message {
    if (!_message) {
        IPhoneXHeigh
        _message = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectMake(20, securitytop_Y + 40, KScreenWidth - 40, 40)
                                                      AndTitle:LOCALIZATION(@"注册")
                                                   AndFontSize:40
                                                 AndTitleColor:Col_3AD
                                                 Numberoflines:0
                                                 TextAlignment:NSTextAlignmentCenter
                                      adjustesFontSizesTowidth:NO
                                                 masksToBounds:NO
                                                 conrenrRadius:0
                                        userInteractionEnabled:NO
                                                    LabelBlock:nil
                                                    lineIsShow:NO
                                                     lineFrame:CGRectZero];
    }
    return _message;
}

- (TT_CustonTF *)login {
    if (!_login) {
        _login = [TT_ControlTool TT_ControlToolTextFieldFrame:CGRectMake(60, CGRectGetMaxY(self.message.frame) + 40, KScreenWidth - 120, 50)
                                                  PlaceHolder:LOCALIZATION(@"   请输入手机号")
                                                  andLifImage:nil
                                                AndRightImage:nil
                                               LiftImageFrame:CGRectZero
                                              RightImageFrame:CGRectZero
                                                       AndTag:0
                                              AndKeyboardType:UIKeyboardTypeDefault
                                              clearButtonMode:UITextFieldViewModeAlways
                                             AndReturnKeyType:UIReturnKeyDone
                                                   lineIsShow:nil lineFrame:CGRectZero];
        _login.layer.cornerRadius = 25;
        _login.layer.masksToBounds = YES;
        _login.layer.borderColor = Col_3AD.CGColor;
        _login.textAlignment = NSTextAlignmentCenter;
        _login.layer.borderWidth = 1;
    }
    return _login;
}

- (TT_CustonTF *)password {
    if (!_password) {
        
        _password = [TT_ControlTool TT_ControlToolTextFieldFrame:CGRectMake(60, CGRectGetMaxY(self.login.frame) + 20, KScreenWidth - 120, 50)
                                                     PlaceHolder:LOCALIZATION(@"   请输入密码")
                                                     andLifImage:nil
                                                   AndRightImage:nil
                                                  LiftImageFrame:CGRectZero
                                                 RightImageFrame:CGRectZero
                                                          AndTag:0
                                                 AndKeyboardType:UIKeyboardTypeDefault
                                                 clearButtonMode:UITextFieldViewModeAlways
                                                AndReturnKeyType:UIReturnKeyDone
                                                      lineIsShow:nil
                                                       lineFrame:CGRectZero];
        _password.layer.cornerRadius = 25;
        _password.layer.masksToBounds = YES;
        _password.layer.borderWidth = 1;
        _password.textAlignment = NSTextAlignmentCenter;
        _password.layer.borderColor = Col_3AD.CGColor;
    }
    return _password;
}

- (UIButton *)login_btn {
    if (!_login_btn) {
        _login_btn = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake(60, CGRectGetMaxY(self.password.frame) + 40, KScreenWidth - 120, 50)
                                                           taeget:self
                                                              sel:@selector(tap_btn:)
                                                              tag:105
                                                         AntTitle:LOCALIZATION(@"立即注册")
                                                        titleFont:16
                                                       titleColor:Col_FFF
                                                         andImage:nil
                                                     AndBackColor:Col_3AD
                                          adjustsFontSizesTowidth:NO
                                                    masksToBounds:YES
                                                     conrenRadius:25
                                                      BorderColor:nil
                                                      BorderWidth:0
                                        ContentHorizontalAligment:0];
        _login_btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _login_btn;
}

- (UIButton *)xieyi_btn {
    if (!_xieyi_btn) {
        IPhoneXHeigh
        _xieyi_btn = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake(60, KScreenHeight - securityBottom_H  - 100, KScreenWidth - 120, 50)
                                                           taeget:self
                                                              sel:@selector(tap_btn:)
                                                              tag:106
                                                         AntTitle:LOCALIZATION(@"注册即代表同意用户协议")
                                                        titleFont:16
                                                       titleColor:Col_666
                                                         andImage:nil
                                                     AndBackColor:nil
                                          adjustsFontSizesTowidth:NO
                                                    masksToBounds:NO
                                                     conrenRadius:0
                                                      BorderColor:nil
                                                      BorderWidth:0
                                        ContentHorizontalAligment:0];
    }
    return _xieyi_btn;
}
@end
