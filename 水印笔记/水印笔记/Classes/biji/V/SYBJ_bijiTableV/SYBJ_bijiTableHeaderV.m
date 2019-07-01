
//
//  SYBJ_bijiTableHeaderV.m
//  水印笔记
//
//  Created by linlin dang on 2019/6/21.
//  Copyright © 2019 TT. All rights reserved.
//

#import "SYBJ_bijiTableHeaderV.h"

@implementation SYBJ_bijiTableHeaderV



- (void)tap_addBtn {
    
    if (self.ViewtapClose) {
        self.ViewtapClose(0, @"");
    }
}

- (void)tt_setupViews {
    [self addSubview:self.title];
    [self addSubview:self.add_btn];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 59, KScreenWidth - 40, 1)];
    line.backgroundColor = Col_EFE;
    [self addSubview:line];
    self.title.frame = CGRectMake(20, 0, 100, 60);
    self.add_btn.frame = CGRectMake(KScreenWidth - 80, 0, 80, 60);
}



- (YYLabel *)title {
    if (!_title) {
        _title = [YYLabel new];
        _title.text = @"笔记本";
        _title.font = [UIFont boldSystemFontOfSize:24];
        _title.textColor = Col_303;
    }
    return _title;
}

- (UIButton *)add_btn {
    if (!_add_btn) {
        _add_btn = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectZero
                                                         taeget:self
                                                            sel:@selector(tap_addBtn)
                                                            tag:0
                                                       AntTitle:nil
                                                      titleFont:0
                                                     titleColor:nil
                                                       andImage:@"CRM_icon_tianjia"
                                                   AndBackColor:nil
                                        adjustsFontSizesTowidth:NO
                                                  masksToBounds:NO
                                                   conrenRadius:0
                                                    BorderColor:nil
                                                    BorderWidth:0
                                      ContentHorizontalAligment:0];
    }
    return _add_btn;
}
@end
