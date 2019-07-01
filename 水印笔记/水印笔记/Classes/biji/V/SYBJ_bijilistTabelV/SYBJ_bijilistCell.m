//
//  SYBJ_bijilistCell.m
//  水印笔记
//
//  Created by TT on 2019/6/28.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "SYBJ_bijilistCell.h"

@implementation SYBJ_bijilistCell



#pragma mark 生命周期

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark 回调协议

#pragma mark 触发方法

- (void)configData:(SYBJ_CatListModel *)Data {
    NSDate *date = [FTT_Helper dateFromString:Data.catlist_Createtime dateFormat:@"yyyy-MM-dd HH:mm"];
    self.time_Lab.text = [FTT_Helper stringWithTimelineDate:date];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:Data.catlist_name];
    text.font = [UIFont boldSystemFontOfSize:14];
    text.color = Col_333;
    text.lineSpacing = 5;
    CGSize maxsize = CGSizeMake(KScreenWidth - 60, MAXFLOAT);
    YYTextLayout *layout1 = [YYTextLayout layoutWithContainerSize:maxsize text:text];
    self.title_LAb.sd_layout
    .heightIs(layout1.textBoundingSize.height);
    self.Bg.sd_layout
    .heightIs(layout1.textBoundingSize.height + 10 + 20 + 20);
    self.title_LAb.attributedText = text;
    [self setupAutoHeightWithBottomView:self.Bg bottomMargin:10];
    
}
#pragma mark 公开方法

#pragma mark 私有方法

- (void)setupSubviewS {
    self.backgroundColor = Col_F0F;
    [self.contentView addSubview:self.Bg];
    [self.Bg addSubview:self.time_Lab];
    [self.Bg addSubview:self.title_LAb];
    [self setupSubViewsFrame];
}

- (void)setupSubViewsFrame {
    self.Bg.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 10);
    
    self.time_Lab.sd_layout
    .leftSpaceToView(self.Bg, 10)
    .rightSpaceToView(self.Bg, 10)
    .topSpaceToView(self.Bg, 10)
    .heightIs(20);
    
    self.title_LAb.sd_layout
    .leftEqualToView(self.time_Lab)
    .rightEqualToView(self.time_Lab)
    .topSpaceToView(self.time_Lab, 10);
}

#pragma mark 存取方法


- (void)setModel:(SYBJ_CatListModel *)model {
    _model = model;
    [self configData:model];
}


- (UIView *)Bg {
    if (!_Bg) {
        _Bg = [TT_ControlTool FTT_ControlToolUIViewFrame:CGRectZero
                                         BackgroundColor:Col_FFF
                                           MasksToBounds:YES
                                           ConrenrRadius:4];
    }
    return _Bg;
}

- (UILabel *)time_Lab {
    if (!_time_Lab) {
        _time_Lab = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                       AndTitle:@""
                                                    AndFontSize:12
                                                  AndTitleColor:Col_3AD
                                                  Numberoflines:0
                                                  TextAlignment:NSTextAlignmentLeft
                                       adjustesFontSizesTowidth:NO
                                                  masksToBounds:NO
                                                  conrenrRadius:0
                                         userInteractionEnabled:NO
                                                     LabelBlock:nil
                                                     lineIsShow:NO
                                                      lineFrame:CGRectZero];
    }
    return _time_Lab;
}

- (UILabel *)title_LAb {
    if (!_title_LAb) {
        _title_LAb = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                        AndTitle:@""
                                                     AndFontSize:14
                                                   AndTitleColor:Col_333
                                                   Numberoflines:0
                                                   TextAlignment:NSTextAlignmentLeft
                                        adjustesFontSizesTowidth:NO
                                                   masksToBounds:NO
                                                   conrenrRadius:0
                                          userInteractionEnabled:NO
                                                      LabelBlock:nil
                                                      lineIsShow:NO
                                                       lineFrame:CGRectZero];
        _title_LAb.font = [UIFont boldSystemFontOfSize:14];
    }
    return _title_LAb;
}
@end
