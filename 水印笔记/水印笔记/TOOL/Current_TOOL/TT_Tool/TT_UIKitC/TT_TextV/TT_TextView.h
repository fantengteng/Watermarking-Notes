//
//  TT_TextView.h
//  TextView
//
//  Created by linlin dang on 2018/12/5.
//  Copyright © 2018 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TT_TextViewDelegate <NSObject>

@optional

- (void)gettextViewH:(CGFloat)textViewH;

- (void)tapTextSure;

@end

@interface TT_TextView : UITextView

/// 占位文字
@property (nonatomic , strong) NSString *tt_placeholder;
/// 占位文字颜色
@property (nonatomic , strong) UIColor *tt_placeholderColor;
/// 占位符字体大小
@property (nonatomic , strong) UIFont *tt_placeholderFont;
/// textView最大行数
@property (nonatomic , assign) NSUInteger maxNumberOfLines;
/// 设置圆角
@property (nonatomic , assign) NSUInteger cornerRadius;
/// 协议
@property (nonatomic , weak) id<TT_TextViewDelegate> tt_Delegate;
/// 初始高度
@property (nonatomic , assign) CGFloat tt_textViewfirstH;

/// UITextView作为placeholderView，使placeholderView等于UITextView的大小，字体重叠显示，方便快捷，解决占位符问题.
@property (nonatomic, strong) UITextView *placeholderView;

- (void)showplaceholdtext;
@end

NS_ASSUME_NONNULL_END
