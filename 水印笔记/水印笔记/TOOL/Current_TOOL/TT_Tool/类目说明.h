
//
//  类目说明.h
//  破竹
//
//  Created by linlin dang on 2019/1/21.
//  Copyright © 2019 米宅. All rights reserved.
//

#ifndef _____h
#define _____h



/// ========================== C ========================== ///

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark 回调协议

#pragma mark 界面跳转

#pragma mark 触发方法

#pragma mark 公开方法

- (void)configureViewFromLocalisation {
    self.title = LOCALIZATION(@"消息");
}

#pragma mark 私有方法

- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
}


#pragma mark 存取方法



/// ========================== V ========================== ///

#pragma mark 生命周期

#pragma mark 回调协议

#pragma mark 触发方法

#pragma mark 公开方法

#pragma mark 私有方法

#pragma mark 存取方法

#pragma mark 生命周期

#pragma mark 回调协议


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableCell *Cell = [HomeTableCell cellWithTableView:tableView CellClass:[HomeTableCell class]];
    Cell.model = self.infodata[indexPath.row];
    @weakify(self)
    Cell.currencyClose = ^(NSInteger num) {
        @strongify(self)
        [self celltapCloseNum:num + indexPath.row data:self.infodata[indexPath.row]];
    };
    return Cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  [tableView cellHeightForIndexPath:indexPath model:self.infodata[indexPath.row] keyPath:@"model" cellClass:[HomeTableCell class] contentViewWidth:KScreenWidth];
}

#pragma mark 触发方法

- (void)celltapCloseNum:(NSInteger)num data:(id)data {
    if (self.tapClose) {
        self.tapClose(num, data);
    }
}
#pragma mark 公开方法

#pragma mark 私有方法

#pragma mark 存取方法


#endif /* _____h */
