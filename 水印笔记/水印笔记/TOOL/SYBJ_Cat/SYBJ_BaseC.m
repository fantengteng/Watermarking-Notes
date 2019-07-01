//
//  SYBJ_BaseC.m
//  水印笔记
//
//  Created by linlin dang on 2019/6/19.
//  Copyright © 2019 TT. All rights reserved.
//

#import "SYBJ_BaseC.h"
#import "SYBJ_API.h"

@interface SYBJ_BaseC ()

@end

@implementation SYBJ_BaseC

- (void)viewDidLoad {
    [super viewDidLoad];
   
}


- (void)tt_bindViewModel {
    [self setupVM:[SYBJ_VM class]];
}


- (void)configDataforNewnetWorkname:(NSString *)networkName
                             params:(NSMutableDictionary *)params {
    [self configDataforNewnetWorkname:networkName params:params networkClass:[SYBJ_API class]];
}




@end
