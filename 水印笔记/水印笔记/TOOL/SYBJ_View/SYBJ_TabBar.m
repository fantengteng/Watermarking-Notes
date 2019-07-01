//
//  SYBJ_TabBar.m
//  水印笔记
//
//  Created by linlin dang on 2019/6/19.
//  Copyright © 2019 TT. All rights reserved.
//

#import "SYBJ_TabBar.h"
#import "AppDelegate.h"
#import "JMTabBarController.h"

#import "SYBJ_biaojiC.h"
#import "SYBJ_kuaijiefangsC.h"
#import "SYBJ_sousuoC.h"
#import "SYBJ_zhanghuC.h"

#import "SYBJ_loginC.h"

@interface TT_BaseNavigationController : UINavigationController

@end

@implementation TT_BaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        if (!IPHONE_X) {
            viewController.hidesBottomBarWhenPushed = YES;
        }else {
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end


@implementation SYBJ_TabBar

+ (instancetype)Share_TabBarTool {
    static SYBJ_TabBar *TT = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TT = [[SYBJ_TabBar alloc]init];
    });
    return TT;
}


- (void)SYBJ_configisLoginv:(UIViewController *)V {
    USER_ID
    if ([usee_id integerValue] == 0) {
        [FTT_Helper CreateTitle:LOCALIZATION(@"提示")
                        message:LOCALIZATION(@"需要登录，才能使用此功能")
                   CantionTitle:LOCALIZATION(@"取消")
                           Sure:LOCALIZATION(@"确定")
                 preferredStyle:UIAlertControllerStyleAlert
                         SureAC:^{
                             [[SYBJ_TabBar Share_TabBarTool]SYBJ_configTTB_loginC:V];
                         } NoAC:^{
                             
                         } ViewController:V];
        return;
    }
}


- (void)SYBJ_configTTB_loginC:(UIViewController *)C {
    SYBJ_loginC *LC = [[SYBJ_loginC alloc]init];
    [C.navigationController pushViewController:LC animated:YES];
    
}




- (void)SYBJ_CreateTabBar {
    
    JMConfig *config = [JMConfig config];
    config.imageSize = CGSizeMake(25, 25);
    config.imageOffset = 4;
    config.norTitleColor = Col_303;
    config.selTitleColor = Col_303;
    config.typeLayout = JMConfigTypeLayoutNormal;
    
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:LOCALIZATION(@"笔记"),LOCALIZATION(@"搜索"),LOCALIZATION(@"足迹"),LOCALIZATION(@"账户"), nil];
    NSMutableArray *imageNormalArr = [NSMutableArray arrayWithObjects:@"shouye_S",@"chazhao_S",@"yangguang_S",@"wode_S", nil];
    NSMutableArray *imageSelectedArr = [NSMutableArray arrayWithObjects:@"shouye",@"chazhao",@"yangguang",@"wode", nil];
    NSMutableArray *controllersArr = [NSMutableArray array];

    [controllersArr addObject:[self configViewController:[[SYBJ_biaojiC alloc]init]]];
    [controllersArr addObject:[self configViewController:[[SYBJ_sousuoC alloc]init]]];
    [controllersArr addObject:[self configViewController:[[SYBJ_kuaijiefangsC alloc]init]]];
    [controllersArr addObject:[self configViewController:[[SYBJ_zhanghuC alloc]init]]];
    
    JMTabBarController *tabBar = [[JMTabBarController alloc]initWithTabBarControllers:controllersArr NorImageArr:imageSelectedArr SelImageArr:imageNormalArr TitleArr:titleArr Config:config];
    AppDelegate* appDelagete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelagete.window.rootViewController = tabBar;

}


- (UIViewController *)configViewController:(UIViewController *)Controller {
    return  [[TT_BaseNavigationController alloc]initWithRootViewController:Controller];
}




@end
