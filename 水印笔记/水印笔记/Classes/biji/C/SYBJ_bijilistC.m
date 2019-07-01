//
//  SYBJ_bijilistC.m
//  水印笔记
//
//  Created by TT on 2019/6/27.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "SYBJ_bijilistC.h"
#import "SYBJ_bijilistTabelV.h"
#import "SYBJ_CatListModel.h"
#import "SYBJ_FabuC.h"
@interface SYBJ_bijilistC ()
@property (nonatomic , strong) SYBJ_bijilistTabelV *TableV;
@end

@implementation SYBJ_bijilistC

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.biji_Catname;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configData];
}

#pragma mark 回调协议

- (void)tapcellTriggereventIndex:(NSIndexPath *)index model:(id)model {
    SYBJ_FabuC *FC = [[SYBJ_FabuC alloc]init];
    FC.CatListModel =  model;
    FC.model = self.model;
    [self JumpController:FC];
}

#pragma mark 界面跳转


- (void)jumpFabuC {
    SYBJ_FabuC *FC = [[SYBJ_FabuC alloc]init];
    FC.model = self.model;
    [self JumpController:FC];
}

#pragma mark 触发方法

- (void)configData {
    USER_ID
    TT_Log(@"%@",[SYBJ_CatListModel findAll]);
    NSString *SQL = [NSString stringWithFormat:@" WHERE cat_ID = %ld ",self.model.biji_Catid];
    NSArray *array = [SYBJ_CatListModel findByCriteria:SQL];
    TT_Log(@"%@",SQL);
    
    if (array.count == 0) {
        [self setupNothingVforImgaeName:@"wushuju" titleName:@"还没有笔记，点击添加笔记" Frame:self.TableV.frame is_Tap:YES];
    }else {
        [self configTabelData:(NSMutableArray *)array has_more:NO];
    }
}


- (void)TapNothingTriggermethod:(NSString *)Str {
    [self jumpFabuC];
}

#pragma mark 公开方法


- (void)tt_addSubviews {
    [self setupTableV:[SYBJ_bijilistTabelV class]];
}


#pragma mark 私有方法

- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
}


#pragma mark 存取方法
@end
