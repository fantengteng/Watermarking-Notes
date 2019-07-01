//
//  SYBJ_BaseC.h
//  水印笔记
//
//  Created by linlin dang on 2019/6/19.
//  Copyright © 2019 TT. All rights reserved.
//

#import "TT_BaseC.h"
#import "SYBJ_VM.h"
NS_ASSUME_NONNULL_BEGIN

@interface SYBJ_BaseC : TT_BaseC

- (void)configDataforNewnetWorkname:(NSString *)networkName
                             params:(NSMutableDictionary *)params;

@end

NS_ASSUME_NONNULL_END
