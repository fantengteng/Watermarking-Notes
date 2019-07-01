

//
//  SYBJ_CatListC.m
//  水印笔记
//
//  Created by TT on 2019/6/28.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "SYBJ_CatListC.h"
#import "SYBJ_bijiTableV.h"
#import "SYBJ_bijiCatmodel.h"
@interface SYBJ_CatListC ()
@property (nonatomic , strong) SYBJ_bijiTableV *TableV;
@end

@implementation SYBJ_CatListC

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loaddata];
}


#pragma mark 回调协议

- (void)tapcellTriggereventIndex:(NSIndexPath *)index model:(id)model {
    if (self.Cat_Delegate && [self.Cat_Delegate respondsToSelector:@selector(tapCatNameAndBack:)]) {
        [self.Cat_Delegate tapCatNameAndBack:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma mark 界面跳转


#pragma mark 触发方法

#pragma mark 公开方法

- (void)loaddata {
    USER_ID
    if (![usee_id isEqualToString:@"0"]) {
        NSString *SQL = [NSString stringWithFormat:@" WHERE biji_userID = '%@' ",usee_id];
        NSArray *array = [SYBJ_bijiCatmodel findByCriteria:SQL];
        if (array.count == 0) {
            [self setupNothingVforImgaeName:@"wushuju" titleName:LOCALIZATION(@"快去添加笔记吧") Frame:self.TableV.frame is_Tap:NO];
        }else {
            [self.TableV configDataNew:array has_more:NO];
        }
    }else {
        [self setupNothingVforImgaeName:@"wushuju" titleName:LOCALIZATION(@"快去添加笔记吧") Frame:self.TableV.frame is_Tap:NO];
    }
}


#pragma mark 私有方法

- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
}


- (void)tt_addSubviews {
    [self setupTableV:[SYBJ_bijiTableV class]];
}



#pragma mark 存取方法

@end
