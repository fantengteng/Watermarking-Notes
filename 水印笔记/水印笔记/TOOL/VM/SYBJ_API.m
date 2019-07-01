//
//  SYBJ_API.m
//  水印笔记
//
//  Created by TT on 2019/6/28.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "SYBJ_API.h"

@implementation SYBJ_API
- (void)configrequestMark:(NSString *)requestMark {
    self.Is_Cache = YES;
    self.requestType = FTT_APIManagerRequestTypeGET;
    self.requestUrl  = [NSString stringWithFormat:@"%@%@",SYBJ_Header,requestMark];
    self.requestMark = requestMark;
}
@end
