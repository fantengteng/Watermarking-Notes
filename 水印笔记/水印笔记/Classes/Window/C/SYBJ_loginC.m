//
//  SYBJ_loginC.m
//  水印笔记
//
//  Created by linlin dang on 2019/6/19.
//  Copyright © 2019 TT. All rights reserved.
//

#import "SYBJ_loginC.h"
#import "SYBJ_RegisetC.h"
#import "SYBJ_UserModel.h"
@interface SYBJ_loginC ()
@property (nonatomic , strong) UILabel *message;
@property (nonatomic , strong) TT_CustonTF *login;
@property (nonatomic , strong) TT_CustonTF *password;
@property (nonatomic , strong) UIButton *regest_btn;
@property (nonatomic , strong) UIButton *login_btn;
@property (nonatomic , strong) UIButton *xieyi_btn;
@end

@implementation SYBJ_loginC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configDefaultModel];
    [self wr_setNavBarShadowImageHidden:YES];
    [self.view addSubview:self.message];
    [self.view addSubview:self.login];
    [self.view addSubview:self.password];
    [self.view addSubview:self.login_btn];
    [self.view addSubview:self.regest_btn];
    [self.view addSubview:self.xieyi_btn];
}


- (void)tap_btn:(UIButton *)btn {
    
    
    switch (btn.tag) {
        case 102:
        {
            [self configLogin];
        }
            break;
        case 103:
        {
            [self JumpController:[[SYBJ_RegisetC alloc]init]];
        }
            break;
        case 104:
        {
            
        }
            break;
            
        default:
            break;
    }
  
}


- (void)configLogin {
    [[FTT_HudTool share_FTT_HudTool]CreateMBProgressHUDModeIndeterminateForVeiw:self.view];
    [[FTT_HudTool share_FTT_HudTool]dissmiss];
    if ([self.login.text isEqualToString:self.login.placeholder] || [self.password.text isEqualToString:self.password.placeholder] || [self.password.text isEqualToString:@""] || [self.login.text isEqualToString:@""]) {
        [[FTT_HudTool share_FTT_HudTool]dissmiss];
        [self configTextTankuangTitle:LOCALIZATION(@"请输入相应的信息")];
    }else {
        NSString *SQL = [NSString stringWithFormat:@" WHERE user_Account = '%@' ",self.login.text];
        NSArray *array = [SYBJ_UserModel findByCriteria:SQL];
        if (array.count == 0) {
            [self configTextTankuangTitle:LOCALIZATION(@"账号不存在，请注册!!!")];
        }else {
            [self configuserInfo:array];
        }
    }
}

/// 存储用户信息
- (void)configuserInfo:(NSArray *)arr {
    
    SYBJ_UserModel *model = arr[0];
    NSString *user_id = [NSString stringWithFormat:@"%ld",model.user_Id];
    SaveObject(user_id, @"userId");
    [self configTankuangTitle:LOCALIZATION(@"登录成功") imageName:@"" Back:^{
    }];
    [self performSelector:@selector(JumpMain) withObject:self afterDelay:1];
}

 - (void)JumpMain {
     [[SYBJ_TabBar Share_TabBarTool]SYBJ_CreateTabBar];
 }



/// 设置默认信息
- (void)configDefaultModel {
    if (![SYBJ_UserModel isAccessibilityElement]) {
        SYBJ_UserModel *model = [[SYBJ_UserModel alloc]init];
        model.user_Password = @"111111";
        model.user_Name = @"16666666666";
        model.user_Account = @"16666666666";
        model.user_HeaderIMG = [UIImage imageNamed:@"icon-user-img"];
        [model save];
    }
}



- (UILabel *)message {
    if (!_message) {
        IPhoneXHeigh
        _message = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectMake(20, securitytop_Y + 40, KScreenWidth - 40, 40)
                                                        AndTitle:@"登录"
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
        UIImageView *IMG = [[UIImageView alloc]initWithFrame:CGRectMake(40, 15, 20, 20)];
        IMG.image = [UIImage imageNamed:@"user"];
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
        [vi addSubview:IMG];
        _login = [TT_ControlTool TT_ControlToolTextFieldFrame:CGRectMake(60, CGRectGetMaxY(self.message.frame) + 40, KScreenWidth - 120, 50)
                                                    PlaceHolder:LOCALIZATION(@"   请输入手机号")
                                                    andLifImage:IMG
                                                  AndRightImage:nil
                                                 LiftImageFrame:CGRectZero
                                                RightImageFrame:CGRectZero
                                                         AndTag:0
                                                AndKeyboardType:UIKeyboardTypeDefault
                                                clearButtonMode:UITextFieldViewModeAlways
                                               AndReturnKeyType:UIReturnKeyDone
                                                     lineIsShow:nil lineFrame:CGRectZero];
        _login.layer.cornerRadius = 25;
        _login.textAlignment = NSTextAlignmentCenter;
        _login.layer.masksToBounds = YES;
        _login.layer.borderColor = Col_3AD.CGColor;
        _login.layer.borderWidth = 1;
    }
    return _login;
}

- (TT_CustonTF *)password {
    if (!_password) {
        UIImageView *IMG = [[UIImageView alloc]initWithFrame:CGRectMake(40, 15, 20, 20)];
        IMG.image = [UIImage imageNamed:@"password"];
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
        [vi addSubview:IMG];
        _password = [TT_ControlTool TT_ControlToolTextFieldFrame:CGRectMake(60, CGRectGetMaxY(self.login.frame) + 20, KScreenWidth - 120, 50)
                                                       PlaceHolder:LOCALIZATION(@"   请输入密码")
                                                       andLifImage:IMG
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
                                                              tag:102
                                                         AntTitle:LOCALIZATION(@"立即登录")
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


- (UIButton *)regest_btn {
    if (!_regest_btn) {
        _regest_btn = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake(60, CGRectGetMaxY(self.login_btn.frame), KScreenWidth - 120, 50)
                                                          taeget:self
                                                             sel:@selector(tap_btn:)
                                                             tag:103
                                                        AntTitle:LOCALIZATION(@"立即注册")
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
        
        _regest_btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _regest_btn;
}
- (UIButton *)xieyi_btn {
    if (!_xieyi_btn) {
        IPhoneXHeigh
        _xieyi_btn = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake(60, KScreenHeight - securityBottom_H  - 100, KScreenWidth - 120, 50)
                                                          taeget:self
                                                             sel:@selector(tap_btn:)
                                                             tag:104
                                                        AntTitle:LOCALIZATION(@"登录即代表同意用户协议")
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
