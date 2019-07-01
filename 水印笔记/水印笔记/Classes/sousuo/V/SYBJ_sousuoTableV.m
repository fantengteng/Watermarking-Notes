
//
//  SYBJ_sousuoTableV.m
//  水印笔记
//
//  Created by TT on 2019/6/28.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "SYBJ_sousuoTableV.h"
#import "SYBJ_CatListModel.h"
@implementation SYBJ_sousuoTableV


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL"];
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SYBJ_CatListModel *model = self.infodata[indexPath.row];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:model.catlist_name];
    text.font = [UIFont boldSystemFontOfSize:14];
    text.color = Col_3AD;
    text.lineSpacing = 5;
    Cell.textLabel.attributedText = text;
    return Cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  50;
}

@end
