//
//  SYBJ_CatListModel.h
//  水印笔记
//
//  Created by linlin dang on 2019/6/21.
//  Copyright © 2019 TT. All rights reserved.
//

#import "Tool_FMDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYBJ_CatListModel : Tool_FMDBModel

/// 分类笔记下面的列表 文章名字
@property (nonatomic , copy) NSString *catlist_name;
/// 分类笔记下面的列表 文章创建时间
@property (nonatomic , copy) NSString *catlist_Createtime;
/// 分类笔记下面的列表。文章内容
@property (nonatomic , copy) NSString *catlist_title;
/// 文章ID
@property (nonatomic , assign) NSInteger catlist_ID;
/// 分类ID
@property (nonatomic , assign) NSInteger cat_ID;
/// 用户ID
@property (nonatomic , assign) NSInteger biji_userID;

@end

NS_ASSUME_NONNULL_END
