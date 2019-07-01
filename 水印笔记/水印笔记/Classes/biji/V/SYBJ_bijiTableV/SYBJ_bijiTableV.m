//
//  SYBJ_bijiTableV.m
//  水印笔记
//
//  Created by linlin dang on 2019/6/21.
//  Copyright © 2019 TT. All rights reserved.
//

#import "SYBJ_bijiTableV.h"
#import "SYBJ_bijiCell.h"
#import "SYBJ_bijiTableHeaderV.h"
@interface SYBJ_bijiTableV ()

@property (nonatomic , strong) SYBJ_bijiTableHeaderV *headerV;


@end
@implementation SYBJ_bijiTableV


#pragma mark 生命周期

#pragma mark 回调协议


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SYBJ_bijiCell *NewHomeCell = [SYBJ_bijiCell cellWithTableView:tableView CellClass:[SYBJ_bijiCell class]];
    NewHomeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [NewHomeCell configData:self.infodata[indexPath.row]];
    return NewHomeCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  60;
}



#pragma mark 触发方法


- (void)celltapCloseNum:(NSInteger)num data:(id)data {
    if (self.TT_delegate && [self.TT_delegate respondsToSelector:@selector(tapviewActiontype:model:)]) {
        [self.TT_delegate tapviewActiontype:num model:data];
    }
}


#pragma mark 公开方法

#pragma mark 私有方法

- (void)setIs_showHeader:(NSInteger)is_showHeader {
    if (is_showHeader == 1) {
        self.tableHeaderView = self.headerV;
        self.tableHeaderView = self.headerV;
        @weakify(self)
        self.headerV.ViewtapClose = ^(NSInteger num, id  _Nonnull data) {
            @strongify(self)
            if (self.tapClose) {
                self.tapClose(num, data);
            }
        };
    }
}

#pragma mark 存取方法

- (SYBJ_bijiTableHeaderV *)headerV {
    if (!_headerV) {
        _headerV = [[SYBJ_bijiTableHeaderV alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 60)];
    }
    return _headerV;
}
@end
