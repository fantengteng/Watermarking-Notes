//
//  SYBJ_sousuoC.m
//  水印笔记
//
//  Created by linlin dang on 2019/6/19.
//  Copyright © 2019 TT. All rights reserved.
//

#import "SYBJ_sousuoC.h"
#import "SYBJ_CatListModel.h"
#import "SYBJ_sousuoTableV.h"
#import "SYBJ_FabuC.h"
#import "SYBJ_bijiCatmodel.h"
@interface SYBJ_sousuoC ()<UISearchBarDelegate>
@property (nonatomic , strong) UISearchBar *searchBar;
@property (nonatomic , strong) SYBJ_sousuoTableV *TableV;
@end

@implementation SYBJ_sousuoC

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.searchBar becomeFirstResponder];
}

#pragma mark 回调协议

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    for(UIView *view in [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    TT_Log(@"点击");
    if ([self.searchBar.text isEqualToString:@""] || [self.searchBar.text isEqualToString:self.searchBar.placeholder]) {
        [self configTextTankuangTitle:LOCALIZATION(@"请输入相应的内容")];
    }else {
        [self Retrievinglocaldata];
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.TableV configDataNew:[NSMutableArray new] has_more:NO];
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void)tapcellTriggereventIndex:(NSIndexPath *)index model:(SYBJ_CatListModel *)model {
    SYBJ_FabuC *FC = [[SYBJ_FabuC alloc]init];
    FC.CatListModel =  model;
    NSString *SQL = [NSString stringWithFormat:@" WHERE biji_Catid = %ld",model.cat_ID];
    FC.model = [SYBJ_bijiCatmodel findFirstByCriteria:SQL];
    [self JumpController:FC];
}

#pragma mark 界面跳转

#pragma mark 触发方法

- (void)Retrievinglocaldata {
    
    NSString *SQL = [NSString stringWithFormat:@" WHERE catlist_name like '%@%%'",self.searchBar.text];
    NSArray *array = [SYBJ_CatListModel findByCriteria:SQL];
    if (array.count == 0) {
        [self setupNothingVforImgaeName:@"wushuju" titleName:LOCALIZATION(@"搜索不到大，请重新输入") Frame:self.TableV.frame is_Tap:YES];
    }else {
        [self configTabelData:(NSMutableArray *)array has_more:NO];
    }
}

#pragma mark 公开方法

- (void)configureViewFromLocalisation {
   
}

#pragma mark 私有方法

- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
}


- (void)tt_addSubviews {
    IPhoneXHeigh
    [self setupTableV:[SYBJ_sousuoTableV class] Frame:CGRectMake(0, securitytop_Y, KScreenWidth, security_H - 49)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.searchBar];

}


#pragma mark 存取方法


- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 0, KScreenWidth - 40, 40)];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.tintColor = Col_3AD;
        _searchBar.delegate  = self;
        _searchBar.placeholder = LOCALIZATION(@"输入你想要搜索的");
    }
    return _searchBar;
}

@end
