//
//  SYBJ_TabBar.h
//  水印笔记
//
//  Created by linlin dang on 2019/6/19.
//  Copyright © 2019 TT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYBJ_TabBar : NSObject
+ (instancetype)Share_TabBarTool;
- (void)SYBJ_CreateTabBar;
- (void)SYBJ_configisLoginv:(UIViewController *)V;
@end

NS_ASSUME_NONNULL_END
