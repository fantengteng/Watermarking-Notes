//
//  SYBJ_AuxiliaryS.h
//  水印笔记
//
//  Created by linlin dang on 2019/6/19.
//  Copyright © 2019 TT. All rights reserved.
//

#ifndef SYBJ_AuxiliaryS_h
#define SYBJ_AuxiliaryS_h

#import "FTT_HudTool.h"
#import "NSString+URL.h"
#import "UIColor+Categpry.h"
#import "UIImage+Rotate.h"
#import "PZ_Animation.h"
#import "TT_ControlTool.h"
#import "Localisator.h"
#import "FTT_Helper.h"
#import "WRNavigationBar.h"
#import "SYBJ_TabBar.h"

#define USER_ID \
NSString *usee_id;\
Exist(@"userId"){\
usee_id = TakeOut(@"userId");\
}else {\
usee_id = @"0";\
}\




#endif /* SYBJ_AuxiliaryS_h */
