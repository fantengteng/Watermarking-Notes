//
//  SYBJ_bijiCell.m
//  水印笔记
//
//  Created by linlin dang on 2019/6/21.
//  Copyright © 2019 TT. All rights reserved.
//

#import "SYBJ_bijiCell.h"
#import "SYBJ_bijiCatmodel.h"
@implementation SYBJ_bijiCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)configData:(SYBJ_bijiCatmodel *)Data {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:Data.biji_Catname];
    text.color = Col_333;
    text.font  = [UIFont boldSystemFontOfSize:16];
    NSMutableAttributedString *num = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  (%ld)",Data.biji_Num]];
    num.color = Col_999;
    num.font  = [UIFont systemFontOfSize:13];
    [text appendAttributedString:num];
    self.title_LAB.attributedText = text;
}

- (void)layoutSubviews {
    self.header_IMG.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView)
    .heightIs(32)
    .widthIs(32);
    
    self.title_LAB.sd_layout
    .leftSpaceToView(self.header_IMG, 10)
    .topEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
}

- (void)setupSubviewS {
    [self.contentView addSubview:self.header_IMG];
    [self.contentView addSubview:self.title_LAB];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 59, KScreenWidth - 40, 1)];
    line.backgroundColor = Col_EFE;
    [self addSubview:line];
}

- (YYAnimatedImageView *)header_IMG {
    if (!_header_IMG) {
        _header_IMG = [YYAnimatedImageView new];
        _header_IMG.image = [UIImage imageNamed:@"yuedu"];
    }
    return _header_IMG;
}


- (YYLabel *)title_LAB {
    if (!_title_LAB) {
        _title_LAB = [YYLabel new];
    }
    return _title_LAB;
}


@end
