//
//  SYBJ_BijiContentModel.h
//  水印笔记
//
//  Created by TT on 2019/6/28.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "Tool_FMDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYBJ_BijiContentModel : Tool_FMDBModel
/// 笔记标题
@property (nonatomic , copy) NSString *biji_title;
/// 笔记内容
@property (nonatomic , copy) NSString *biji_content;
/// 笔记创建时间
@property (nonatomic , copy) NSString *biji_creatTime;
/// 文章ID
@property (nonatomic , assign) NSInteger biji_ID;
@end

NS_ASSUME_NONNULL_END
