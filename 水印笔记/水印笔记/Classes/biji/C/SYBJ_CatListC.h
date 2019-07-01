//
//  SYBJ_CatListC.h
//  水印笔记
//
//  Created by TT on 2019/6/28.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "SYBJ_BaseC.h"

@protocol SYBJ_CatListCProtocol <NSObject>

- (void)tapCatNameAndBack:(id)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SYBJ_CatListC : SYBJ_BaseC
@property (nonatomic , weak) id<SYBJ_CatListCProtocol>Cat_Delegate;
@end

NS_ASSUME_NONNULL_END
