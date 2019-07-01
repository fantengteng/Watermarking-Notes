//
//  SYBJ_addBijiC.m
//  水印笔记
//
//  Created by linlin dang on 2019/6/21.
//  Copyright © 2019 TT. All rights reserved.
//

#import "SYBJ_addBijiC.h"
#import "TT_TextView.h"
#import "SYBJ_bijiCatmodel.h"
@interface SYBJ_addBijiC ()<TT_TextViewDelegate>
@property (nonatomic , strong) TT_TextView *TextV;
@end

@implementation SYBJ_addBijiC

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tt_addnavgarItme];
    
}


#pragma mark 回调协议

#pragma mark 界面跳转

#pragma mark 触发方法


- (void)chuangjian {
    if ([self.TextV.text isEqualToString:@""] || [self.TextV.text isEqualToString:self.TextV.tt_placeholder]) {
        [[FTT_HudTool share_FTT_HudTool]CreateHUD:LOCALIZATION(@"请输入笔记名") AndView:self.view AndMode:MBProgressHUDModeText AndImage:nil AndAfterDelay:1 AndBack:nil];
    }else {
        [self configbaocunbijiming:self.TextV.text];
    }
}


- (void)configbaocunbijiming:(NSString *)bijiming {
    if ([SYBJ_bijiCatmodel isAccessibilityElement]) {
        [self configaddbijiming:bijiming];
    }else {
        NSString *SQL = [NSString stringWithFormat:@" WHERE biji_Catname = '%@' ",bijiming];
        NSArray *array = [SYBJ_bijiCatmodel findByCriteria:SQL];
        if (array.count != 0) {
            [self configTextTankuangTitle:LOCALIZATION(@"笔记本已存在，请重新输入")];
        }else {
            [self configaddbijiming:bijiming];
        }
    }
   
    
   
    
}

/// 添加笔记名
- (void)configaddbijiming:(NSString *)bijiming {
    USER_ID
    SYBJ_bijiCatmodel *model = [[SYBJ_bijiCatmodel alloc]init];
    model.biji_Num = 0;
    model.biji_Catname = bijiming;
    model.biji_userID = [usee_id integerValue];

    NSString *msg;
    if ([model save]) {
        msg = @"创建成功";
    }else {
        msg = @"创建失败";
    }
    [[FTT_HudTool share_FTT_HudTool]CreateHUD:msg AndView:self.view AndMode:MBProgressHUDModeText AndImage:nil AndAfterDelay:1 AndBack:nil];
 
}
#pragma mark 公开方法



#pragma mark 私有方法

- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
    self.title = LOCALIZATION(@"新建笔记本") ;
    [self.view addSubview:self.TextV];
    [self.view endEditing:YES];
}

- (void)tt_addnavgarItme {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"创建" style:UIBarButtonItemStylePlain target:self action:@selector(chuangjian)];
    [self.navigationItem.rightBarButtonItem setTintColor:Col_3AD];
}




#pragma mark 存取方法


- (TT_TextView *)TextV {
    if (!_TextV) {
        _TextV = [[TT_TextView alloc]initWithFrame:CGRectMake(20, 100, KScreenWidth - 40, 150)];
        _TextV.textAlignment = NSTextAlignmentCenter;
        _TextV.tt_placeholderFont = [UIFont boldSystemFontOfSize:20];
        _TextV.tt_placeholder  = @"笔记本";
        _TextV.placeholderView.textAlignment = NSTextAlignmentCenter;
        _TextV.textColor = Col_333;
        _TextV.font = [UIFont boldSystemFontOfSize:20];
        _TextV.tt_Delegate = self;
    }
    return _TextV;
}


@end
