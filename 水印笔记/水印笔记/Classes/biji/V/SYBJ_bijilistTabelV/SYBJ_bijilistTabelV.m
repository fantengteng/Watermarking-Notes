//
//  SYBJ_bijilistTabelV.m
//  水印笔记
//
//  Created by TT on 2019/6/27.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "SYBJ_bijilistTabelV.h"
#import "SYBJ_bijilistCell.h"
@implementation SYBJ_bijilistTabelV



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SYBJ_bijilistCell *NewHomeCell = [SYBJ_bijilistCell cellWithTableView:tableView CellClass:[SYBJ_bijilistCell class]];
    NewHomeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewHomeCell.model = self.infodata[indexPath.row];
    return NewHomeCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  [tableView cellHeightForIndexPath:indexPath model:self.infodata[indexPath.row] keyPath:@"model" cellClass:[SYBJ_bijilistCell class] contentViewWidth:KScreenWidth];
}


- (void)changeDefaultConfigguration {
    self.backgroundColor = Col_F0F;
}


@end
