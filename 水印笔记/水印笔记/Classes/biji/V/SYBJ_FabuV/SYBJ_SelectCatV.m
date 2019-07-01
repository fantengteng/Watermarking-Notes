
//
//  SYBJ_SelectCatV.m
//  水印笔记
//
//  Created by TT on 2019/6/28.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "SYBJ_SelectCatV.h"

@interface SYBJ_SelectCatV ()

@property (nonatomic , strong) UIImageView *ImG;
@property (nonatomic , strong) YYLabel *Text;
@property (nonatomic , strong) UIView *line;

@end

@implementation SYBJ_SelectCatV

#pragma mark 生命周期

#pragma mark 回调协议

#pragma mark 触发方法


- (void)TaP {
    [self generaltriggermethodType:1 data:@""];
}

#pragma mark 公开方法

- (void)configData:(NSString *)text {
    NSMutableAttributedString *Text = [[NSMutableAttributedString alloc]initWithString:text];
    UIImage *image = [UIImage imageNamed:@"down-2"];
    UIFont *font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:[UIFont systemFontOfSize:10] alignment:YYTextVerticalAlignmentCenter];
    [Text appendString:@" "];
    [Text appendAttributedString:attachText];
    Text.color = Col_3AD;
    Text.font = font;
    self.Text.attributedText = Text;
}

#pragma mark 私有方法


- (void)tt_setupViews {
    [self addSubview:self.ImG];
    [self addSubview:self.Text];
    [self addSubview:self.line];
}


- (void)tt_configDefault {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TaP)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}


#pragma mark 存取方法

- (UIImageView *)ImG {
    if (!_ImG) {
        _ImG = [TT_ControlTool FTT_ControlToolUIImageViewFrame:CGRectMake(20, 10, 25, 25)
                                                     ImageName:@"yuedu"
                                        userInteractionEnabled:NO
                                                 MasksToBounds:NO
                                                 ConrenrRadius:0
                                                   BorderColor:nil
                                                   BorderWidth:0
                                                    LabelBlock:nil];
    }
    return _ImG;
}


- (YYLabel *)Text {
    if (!_Text) {
        _Text = [YYLabel new];
        _Text.frame = CGRectMake(50, 0, self.V_screnW - 50 - 50, self.V_screnH - 1);
    }
    return _Text;
}

- (UIView *)line {
    if (!_line) {
        _line = [TT_ControlTool FTT_ControlToolUIViewFrame:CGRectMake(50, self.V_screnH - 1, self.Text.width, 1)
                                           BackgroundColor:Col_ECE
                                             MasksToBounds:NO
                                             ConrenrRadius:0];
    }
    return _line;
}
@end
