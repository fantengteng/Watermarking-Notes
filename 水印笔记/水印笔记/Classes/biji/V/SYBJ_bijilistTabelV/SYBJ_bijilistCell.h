//
//  SYBJ_bijilistCell.h
//  水印笔记
//
//  Created by TT on 2019/6/28.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "TT_BaseCell.h"
#import "SYBJ_CatListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SYBJ_bijilistCell : TT_BaseCell
@property (nonatomic , strong) UIView *Bg;
@property (nonatomic , strong) UILabel *time_Lab;
@property (nonatomic , strong) UILabel *title_LAb;
@property (nonatomic , strong) SYBJ_CatListModel *model;
@end

NS_ASSUME_NONNULL_END
