//
//  SYBJ_VM.m
//  水印笔记
//
//  Created by linlin dang on 2019/6/19.
//  Copyright © 2019 TT. All rights reserved.
//

#import "SYBJ_VM.h"

@implementation SYBJ_VM
- (void)dataConversion:(FTT_APIBaseManager *)Manager {
    if ([Manager.requestMark isEqualToString:uploadTokenMarK]) {
        [self uploadTokenmethod:Manager];
    }
}


- (void)uploadTokenmethod:(FTT_APIBaseManager *)Manager {
    SaveObject(Manager.responseObject[@"data"][@"token"], @"IMG_T")
    [self ElasticGeneralmethod:Manager];
}

@end
