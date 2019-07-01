//
//  SYBJ_bijiCatmodel.h
//  水印笔记
//
//  Created by linlin dang on 2019/6/21.
//  Copyright © 2019 TT. All rights reserved.
//

#import "Tool_FMDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYBJ_bijiCatmodel : Tool_FMDBModel

@property (nonatomic , assign) NSInteger biji_Catid;

@property (nonatomic , assign) NSInteger biji_Num;

@property (nonatomic , copy) NSString *biji_CreateTime;

@property (nonatomic , copy) NSString *biji_Catname;

@property (nonatomic , assign) NSInteger biji_userID;

@end

NS_ASSUME_NONNULL_END
