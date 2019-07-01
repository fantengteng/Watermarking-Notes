//
//  SYBJ_biaojiC.m
//  水印笔记
//
//  Created by linlin dang on 2019/6/19.
//  Copyright © 2019 TT. All rights reserved.
//

#import "SYBJ_biaojiC.h"
#import "SYBJ_bijiTableV.h"
#import "SYBJ_addBijiC.h"
#import "SYBJ_bijilistC.h"
#import "SYBJ_bijiCatmodel.h"
@interface SYBJ_biaojiC ()
@property (nonatomic , strong) SYBJ_bijiTableV *TableV;
@end

@implementation SYBJ_biaojiC

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loaddata];
}
#pragma mark 回调协议

- (void)tt_allClose {
    @weakify(self)
    self.TableV.tapClose = ^(NSInteger num, id data) {
        @strongify(self)
        [[SYBJ_TabBar Share_TabBarTool]SYBJ_configisLoginv:self];
        [self jumpaddbijiC];
    };
}

- (void)tapcellTriggereventIndex:(NSIndexPath *)index model:(id)model {
    [self jumpbijilistC:model];
}

#pragma mark 界面跳转

- (void)jumpaddbijiC {
    SYBJ_addBijiC *AC = [[SYBJ_addBijiC alloc]init];
    [self JumpController:AC];
}

- (void)jumpbijilistC:(id)model{
    SYBJ_bijilistC *bijilistC = [[SYBJ_bijilistC alloc]init];
    bijilistC.model= model;
    [self JumpController:bijilistC];
}
#pragma mark 触发方法


- (void)loaddata {
    USER_ID
    IPhoneXHeigh
    if (![usee_id isEqualToString:@"0"]) {
        NSString *SQL = [NSString stringWithFormat:@" WHERE biji_userID = '%@' ",usee_id];
        NSArray *array = [SYBJ_bijiCatmodel findByCriteria:SQL];
        if (array.count == 0) {
            [self setupNothingVforImgaeName:@"wushuju" titleName:LOCALIZATION(@"快去添加笔记吧") Frame:CGRectMake(0, securitytop_Y + 50, KScreenWidth, security_H - 49 - 50) is_Tap:YES];
        }else {
            [self.NothingV removeFromSuperview];
           [self.TableV configDataNew:array has_more:NO];
        }
    }else {
        [self setupNothingVforImgaeName:@"wushuju" titleName:LOCALIZATION(@"快去添加笔记吧") Frame:CGRectMake(0, securitytop_Y + 50, KScreenWidth, security_H - 49 - 50) is_Tap:YES];
    }
}

- (void)TapNothingTriggermethod:(NSString *)Str {
    [[SYBJ_TabBar Share_TabBarTool]SYBJ_configisLoginv:self];
    [self jumpaddbijiC];
}


#pragma mark 公开方法


- (void)tt_addSubviews {
    [self setupTableV:[SYBJ_bijiTableV class]];
    self.TableV.is_showHeader = 1;
    [self tt_allClose];
}


#pragma mark 私有方法

- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
}


#pragma mark 存取方法
@end
