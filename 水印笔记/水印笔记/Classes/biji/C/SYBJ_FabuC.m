//
//  SYBJ_FabuC.m
//  水印笔记
//
//  Created by TT on 2019/6/28.
//  Copyright © 2019年 TT. All rights reserved.
//

#import "SYBJ_FabuC.h"
#import "WGCommon.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import "TZImagePickerController/TZImagePickerController.h"
#import "SYBJ_SelectCatV.h"
#import "SYBJ_CatListC.h"

#define kEditorURL @"richText_editor"



@interface SYBJ_FabuC ()<KWFontStyleBarDelegate,UIWebViewDelegate,KWEditorBarDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate,SYBJ_CatListCProtocol>

@property (nonatomic , strong) NSMutableArray *uploadPics;

@property (nonatomic , strong) KWEditorBar *toolBarView;

@property (nonatomic , strong) KWFontStyleBar *fontBar;

@property (nonatomic , assign) BOOL showHtml;

@property (nonatomic , strong) UIWebView *webView;

@property (strong, nonatomic) CLLocation *location;

@property (nonatomic , strong) UIImagePickerController *imagePickerVc;

@property (nonatomic , strong) NSOperationQueue *operationQueue;

@property (nonatomic , strong) NSMutableArray *arrUrl;

@property (nonatomic , strong) SYBJ_SelectCatV *SelectCatV;

@end
@implementation SYBJ_FabuC


#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    IPhoneXHeigh
    self.webView.frame = CGRectMake(0 , securitytop_Y + 50, kScreenWidth,KScreenHeight - KWEditorBar_Height - securitytop_Y - 50);
}


- (void)dealloc{
    @try {
        [self.toolBarView removeObserver:self forKeyPath:@"transform"];
    } @catch (NSException *exception)
    {
        
    } @finally {
    }
    [self tt_deletNoti];
}


#pragma mark 回调协议

- (void)tapCatNameAndBack:(id)model {
    self.model = model;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    TT_Log(@"loadURL = %@",urlString);
    [self handleEvent:urlString];
    if ([urlString rangeOfString:@"re-state-content://"].location != NSNotFound) {
        NSString *className = [urlString stringByReplacingOccurrencesOfString:@"re-state-content://" withString:@""];
        
        [self.fontBar updateFontBarWithButtonName:className];
        
        if ([self.webView contentText].length <= 0) {
            [self.webView showContentPlaceholder];
            if ([self getImgTags:[self.webView contentHtmlText]].count > 0) {
                [self.webView clearContentPlaceholder];
            }
        }else{
            [self.webView clearContentPlaceholder];
        }
        
        if ([[className componentsSeparatedByString:@","] containsObject:@"unorderedList"]) {
            [self.webView clearContentPlaceholder];
        }
        
    }
    [self handleWithString:urlString];
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.Is_hideJuhuazhuan = NO;
    if (self.CatListModel) {
        [self.webView clearContentPlaceholder];
        [self.webView setupTitle:self.CatListModel.catlist_name];
        [self.webView setupContent:self.CatListModel.catlist_title];
    }
}

- (void)editorBar:(KWEditorBar *)editorBar didClickIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            //显示或隐藏键盘
            if (self.toolBarView.transform.ty < 0) {
                [self.webView hiddenKeyboard];
            }else{
                [self.webView showKeyboardContent];
            }
        }
            break;
        case 1:{
            //回退
            [self.webView stringByEvaluatingJavaScriptFromString:@"document.execCommand('undo')"];
        }
            break;
        case 2:{
            [self.webView stringByEvaluatingJavaScriptFromString:@"document.execCommand('redo')"];
        }
            break;
        case 3:{
            //显示更多区域
            editorBar.fontButton.selected = !editorBar.fontButton.selected;
            if (editorBar.fontButton.selected) {
                [self.view addSubview:self.fontBar];
            }else{
                [self.fontBar removeFromSuperview];
            }
        }
            break;
        case 4:{
            [self fabuxinxi];
        }
            break;
        case 5:{
            //插入图片
            if (!self.toolBarView.keyboardButton.selected) {
                [self.webView showKeyboardContent];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showPhotos];
                });
            }else{
                [self showPhotos];
            }
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - fontbardelegate
- (void)fontBar:(KWFontStyleBar *)fontBar didClickBtn:(UIButton *)button{
    if (self.toolBarView.transform.ty>=0) {
        [self.webView showKeyboardContent];
    }
    switch (button.tag) {
        case 0:{
            //粗体
            [self.webView bold];
        }
            break;
        case 1:{//下划线
            [self.webView underline];
        }
            break;
        case 2:{//斜体
            [self.webView italic];
        }
            break;
        case 3:{//14号字体
            [self.webView setFontSize:@"2"];
        }
            break;
        case 4:{//16号字体
            [self.webView setFontSize:@"3"];
        }
            break;
        case 5:{//18号字体
            [self.webView setFontSize:@"4"];
        }
            break;
        case 6:{//左对齐
            [self.webView justifyLeft];
        }
            break;
        case 7:{//居中对齐
            [self.webView justifyCenter];
        }
            break;
        case 8:{//右对齐
            [self.webView justifyRight];
        }
            break;
        case 9:{//无序
            [self.webView unorderlist];
        }
            break;
        case 10:{
            //缩进
            button.selected = !button.selected;
            if (button.selected) {
                [self.webView indent];
            }else{
                [self.webView outdent];
            }
        }
            break;
        case 11:{
            
        }
            break;
        default:
            break;
    }
    
}

- (void)fontBarResetNormalFontSize{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView normalFontSize];
    });
}


#pragma mar - webView监听处理事件
- (void)handleEvent:(NSString *)urlString{
    if ([urlString hasPrefix:@"re-state-content://"]) {
        self.fontBar.hidden = NO;
        self.toolBarView.hidden = NO;
    }
    
    if ([urlString hasPrefix:@"re-state-title://"]) {
        self.fontBar.hidden = YES;
        self.toolBarView.hidden = YES;
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
            }
        }];
    }
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    [self configChangeIMG:photos];
}


- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [self configChangeIMG:@[image]];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)uploadImages:(WGUploadPictureModel*)uploadM {
    NSString *token = TakeOut(@"IMG_T");
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = [QNFixedZone zone1];
    }];
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    NSTimeInterval time= [[NSDate new] timeIntervalSince1970];
    NSString *filename = [NSString stringWithFormat:@"%@_%ld_%.f.%@",@"status",686734963504054272,time,@"jpg"];
    [upManager putData:uploadM.imageData
                   key:filename
                 token:token
              complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  if (info.isOK) {
                      NSString *img_URL = [NSString stringWithFormat:@"http://tt.midichan.com/%@",key];
                      [self.webView inserSuccessImageKey:uploadM.key imgUrl:img_URL];
                      [self.arrUrl addObject:img_URL];
                      uploadM.type = WGUploadImageModelTypeSuccess;
                      if ([self.uploadPics containsObject:uploadM]) {
                          [self.uploadPics removeObject:uploadM];
                      }
                  }else {
                      [self.webView uploadErrorKey:uploadM.key];
                      uploadM.type = WGUploadImageModelTypeError;
                      [self.uploadPics addObject:uploadM];
                  }
              } option:nil];
}

#pragma mark 界面跳转

- (void)JumpCatlistC {
    SYBJ_CatListC *Cat = [[SYBJ_CatListC alloc]init];
    Cat.Cat_Delegate = self;
    [self JumpController:Cat];
}

#pragma mark 触发方法

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"transform"]){
        IPhoneXHeigh
        CGRect fontBarFrame = self.fontBar.frame;
        fontBarFrame.origin.y = CGRectGetMaxY(self.toolBarView.frame)- KWFontBar_Height - KWEditorBar_Height;
        self.fontBar.frame = fontBarFrame;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)showPhotos {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

//获取IMG标签
-(NSArray*)getImgTags:(NSString *)htmlText
{
    if (htmlText == nil) {
        return nil;
    }
    NSError *error;
    NSString *regulaStr = @"<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:htmlText options:0 range:NSMakeRange(0, [htmlText length])];
    
    return arrayOfAllMatches;
}

- (void)configChangeIMG:(NSArray *)IMG {
    if (IMG.count > 0) {
        for (UIImage *img in IMG) {
            WGUploadPictureModel *uploadM = [[WGUploadPictureModel alloc]init];
            uploadM.image = img;
            uploadM.key = [NSString uuid];
            uploadM.imageData = UIImageJPEGRepresentation(img,0.8f);
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self.webView inserImage:uploadM.imageData key:uploadM.key];
                //2、模拟网络请求上传图片 更新进度
                [self.webView inserImageKey:uploadM.key progress:0.5];
                [self uploadImages:uploadM];
            });
        }
    }
}

#pragma mark -keyboard
- (void)keyBoardWillChangeFrame:(NSNotification*)notification{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (frame.origin.y == KScreenHeight) {
        [UIView animateWithDuration:duration animations:^{
            self.toolBarView.transform =  CGAffineTransformIdentity;
            self.toolBarView.keyboardButton.selected = NO;
        }];
    }else{
        IPhoneXHeigh
        [UIView animateWithDuration:duration animations:^{
            self.toolBarView.transform = CGAffineTransformMakeTranslation(0, -frame.size.height + securityBottom_H);
            self.toolBarView.keyboardButton.selected = YES;
            
        }];
    }
}

- (void)fabuxinxi {
    __block NSString *htmlStr = [self.webView contentHtmlText];
    //过滤掉无效视图
    NSString *divReg = @"<div[^>]*>.*?</div>";
    NSArray *divArray = [self matchString:htmlStr toRegexString:divReg];
    if (divArray.count > 0) {
        [divArray enumerateObjectsUsingBlock:^(
                                               NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            if (obj.length > 0 && [obj containsString:@"class=\"real-img-f-div\""]) {
                NSString *imgReg = @"<img[^>]*>";
                NSArray *imgArray = [self matchString:obj toRegexString:imgReg];
                [imgArray
                 enumerateObjectsUsingBlock:^(NSString *_Nonnull obj2,
                                              NSUInteger idx, BOOL *_Nonnull stop) {
                     if (obj2.length > 0 &&
                         ![obj2 containsString:@"class=\"real-img-delete\""]) {
                         //删除id
                         NSString *imgIDReg = @"id=\".*?\"";
                         NSString *imgStr = [self matchReplaceHtmlString:obj2
                                                             RegexString:imgIDReg
                                                              withString:@""];
                         htmlStr = [htmlStr stringByReplacingOccurrencesOfString:obj
                                                                      withString:imgStr];
                         
                         
                     }
                 }];
            }
        }];
    }
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
    TT_Log(@"%@",htmlStr);
    if ([htmlStr isEqualToString:@""] || [[self.webView titleText] isEqualToString:@""]) {
        [[FTT_HudTool share_FTT_HudTool]CreateHUD:LOCALIZATION(@"请输入相应的数据")
                                          AndView:self.view
                                          AndMode:MBProgressHUDModeText
                                         AndImage:nil
                                    AndAfterDelay:1
                                          AndBack:nil];
    }else {
        [self configFabu:htmlStr];
    }
    
}


- (void)configFabu:(NSString *)htmlStr {
   
    NSString *Str = LOCALIZATION(@"添加失败");
    if (!self.CatListModel) {
        USER_ID
        SYBJ_CatListModel *model = [[SYBJ_CatListModel alloc]init];
        model.catlist_title = htmlStr;
        model.catlist_name = [self.webView titleText];
        model.catlist_Createtime = [FTT_Helper loadNewTime:@"yyyy-MM-dd HH:mm"];
        model.cat_ID = self.model.biji_Catid;
        model.biji_userID = [usee_id integerValue];
        self.model.biji_Num = self.model.biji_Num  + 1;
        [self.model update];
        if ([model save]) {
            Str = LOCALIZATION(@"添加成功");
        }
    }else {
        self.CatListModel.catlist_name = [self.webView titleText];;
        self.CatListModel.catlist_title = htmlStr;
        self.CatListModel.catlist_Createtime = [FTT_Helper loadNewTime:@"yyyy-MM-dd HH:mm"];;
        self.CatListModel.cat_ID = self.model.biji_Catid;
        if ([self.CatListModel update]) {
            Str = LOCALIZATION(@"更新成功");
        }else {
            Str = LOCALIZATION(@"更新失败");
        }
        [self.CatListModel update];
    }
   
   
    [[FTT_HudTool share_FTT_HudTool]CreateHUD:Str AndView:self.view AndMode:MBProgressHUDModeText AndImage:nil AndAfterDelay:1 AndBack:nil];
}




#pragma mark - 正则匹配
- (NSArray *)matchString:(NSString *)string toRegexString:(NSString *)regexStr {
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:regexStr
                                  options:NSRegularExpressionCaseInsensitive
                                  error:nil];
    
    NSArray *matches = [regex matchesInString:string
                                      options:0
                                        range:NSMakeRange(0, [string length])];
    // match: 所有匹配到的字符,根据() 包含级
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSTextCheckingResult *match in matches) {
        for (int i = 0; i < [match numberOfRanges]; i++) {
            //以正则中的(),划分成不同的匹配部分
            NSString *component = [string substringWithRange:[match rangeAtIndex:i]];
            
            [array addObject:component];
        }
    }
    return array;
}

/**
 :正则替换
 */
- (NSString *)matchReplaceHtmlString:(NSString *)string
                         RegexString:(NSString *)regexStr
                          withString:(NSString *)replaceStr {
    if (!string || string.length == 0 || regexStr.length == 0 ||
        replaceStr.length == 0) {
        return string;
    }
    
    NSRegularExpression *regularExpretion =
    [NSRegularExpression regularExpressionWithPattern:regexStr
                                              options:0
                                                error:nil];
    string = [regularExpretion
              stringByReplacingMatchesInString:string
              options:NSMatchingReportProgress
              range:NSMakeRange(0, string.length)
              withTemplate:replaceStr];
    
    return string;
}
#pragma mark -图片点击操作
- (BOOL)handleWithString:(NSString *)urlString{
    
    //点击的图片标记URL（自定义）
    NSString *preStr = @"protocol://iOS?code=uploadResult&data=";
    
    if ([urlString hasPrefix:preStr]) {
        NSString *result = [urlString stringByReplacingOccurrencesOfString:preStr withString:@" "];
        NSString *jsonString = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        NSString *meg = [NSString stringWithFormat:@"上传的图片ID为%@",dict[@"imgId"]];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:meg message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        //上传状态 - 默认上传成功
        BOOL uploadState = YES;
        WGUploadPictureModel *model;
        for (WGUploadPictureModel *upPic in self.uploadPics) {
            if ([upPic.key isEqualToString:dict[@"imgId"]] && upPic.type == WGUploadImageModelTypeError) {
                uploadState = false;
                model = upPic;
            }
        }
        UIAlertAction *ok = [UIAlertAction actionWithTitle:uploadState?@"删除图片":@"重新上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //根据自身业务需要处理图片操作：如删除、重新上传图片操作等
            if (uploadState) {
                //例如删除图片执行函数imgID=key;
                [self.webView deleteImageKey:dict[@"imgId"]];
            }else{
                [self uploadImages:model];
            }
        }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    return YES;
}
#pragma mark 公开方法

- (void)tt_addSubviews {
    [self.view addSubview:self.SelectCatV];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.toolBarView];
    self.toolBarView.delegate = self;
    [self.toolBarView addObserver:self forKeyPath:@"transform" options:
     NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    @weakify(self)
    self.SelectCatV.ViewtapClose = ^(NSInteger num, id  _Nonnull data) {
        @strongify(self)
        [self JumpCatlistC];
    };
    
}

- (void)tt_addNoti {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}



- (void)configData {
    [self configDataforNewnetWorkname:uploadTokenMarK params:[NSMutableDictionary new]];
}


#pragma mark 私有方法

- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:kEditorURL                                                              ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
}



#pragma mark 存取方法

- (void)setModel:(SYBJ_bijiCatmodel *)model {
    _model = model;
    [self.SelectCatV configData:model.biji_Catname];
}

- (NSMutableArray *)uploadPics {
    if (!_uploadPics) {
        _uploadPics = [NSMutableArray new];
    }
    return _uploadPics;
}

- (KWEditorBar *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [KWEditorBar editorBar];
        IPhoneXHeigh
        _toolBarView.frame = CGRectMake(0, KScreenHeight - securityBottom_H - 44, kScreenWidth, 44);
        _toolBarView.backgroundColor = COLOR(237, 237, 237, 1);
    }
    return _toolBarView;
}


- (KWFontStyleBar *)fontBar {
    if (!_fontBar) {
        _fontBar = [[KWFontStyleBar alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.toolBarView.frame) - KWFontBar_Height - KWEditorBar_Height, kScreenWidth, KWFontBar_Height)];
        _fontBar.delegate = self;
    }
    return _fontBar;
}


- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.scrollView.bounces = NO;
        _webView.hidesInputAccessoryView = YES;
    }
    return _webView;
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}


- (NSMutableArray *)arrUrl {
    if (!_arrUrl) {
        _arrUrl = [NSMutableArray new];
    }
    return _arrUrl;
}

- (SYBJ_SelectCatV *)SelectCatV {
    if (!_SelectCatV) {
        IPhoneXHeigh
        _SelectCatV = [[SYBJ_SelectCatV alloc]initWithFrame:CGRectMake(0, securitytop_Y, KScreenWidth, 50)];
    }
    return _SelectCatV;
}

@end
