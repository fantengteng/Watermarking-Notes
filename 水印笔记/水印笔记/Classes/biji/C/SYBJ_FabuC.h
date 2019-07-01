//
//  SYBJ_FabuC.h
//  水印笔记
//
//  Created by TT on 2019/6/28.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "SYBJ_BaseC.h"
#import "SYBJ_bijiCatmodel.h"
#import "SYBJ_CatListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SYBJ_FabuC : SYBJ_BaseC
@property (nonatomic , strong) SYBJ_bijiCatmodel *model;
@property (nonatomic , strong) SYBJ_CatListModel *CatListModel;
@property (nonatomic , assign) NSInteger type;
@end

NS_ASSUME_NONNULL_END
