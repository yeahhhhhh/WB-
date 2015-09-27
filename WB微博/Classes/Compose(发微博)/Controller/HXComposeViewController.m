//
//  HXComposeViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/9/23.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXComposeViewController.h"
#import "HXTextView.h"
#import "MJExtension.h"
#import "AccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "userModle.h"
#import "UIView+Extension.h"
#import "HXComposeToolbar.h"//添加键盘上方的工具条
#import "HXComposePhotpView.h"
#import "HXEmotionKeyboard.h"//添加表情键盘

@interface HXComposeViewController ()<UITextViewDelegate,HXComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 输入控件 */
@property (nonatomic, weak) HXTextView *textView;
/** 键盘顶部的工具条*/
@property (nonatomic, weak) HXComposeToolbar *toolbar;
/** 相册 （存放拍照或者相册选取的图片）*/
@property (nonatomic, weak) HXComposePhotpView *photosView;
/**表情键盘*/
@property (nonatomic, strong) HXEmotionKeyboard *emotionKeyboard;
/** 是否正在切换键盘*/
@property (nonatomic, assign) BOOL *switchingKeyboard;
@end

@implementation HXComposeViewController

#pragma mark - 懒加载
- (HXEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard)
    {
        self.emotionKeyboard =  [[HXEmotionKeyboard alloc]init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 260;
    }
    return _emotionKeyboard;
}
#pragma mark - 系统方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏内容
    [self setupNav];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
    
    // 添加相册
    [self setupPhotosView];
    // 默认是YES：当scrollView遇到UINavigationBar、UITabBar等控件时，默认会设置scrollView的contentInset
    //    self.automaticallyAdjustsScrollViewInsets;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //成为第一响应者（能输入文字的空件一旦成为第一响应者 就会叫出相应的键盘）
    [self.textView becomeFirstResponder];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 初始化方法
/**
 * 初始化相册
 */
- (void)setupPhotosView
{
    HXComposePhotpView *photosView = [[HXComposePhotpView alloc]init];
    photosView.width = self.view.width - 20;
    photosView.height = self.view.height;//高度 随意
    photosView.x = 10;
    photosView.y = 100;
//    photosView.backgroundColor = [UIColor redColor];
    [self.textView addSubview:photosView];
    self.photosView = photosView;
    
}
/**
 * 初始化工具条
 */
- (void)setupToolbar
{
    HXComposeToolbar *toolbar = [[HXComposeToolbar alloc]init];
//    Toolbar.backgroundColor = [UIColor yellowColor];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    self.toolbar = toolbar;
    
    toolbar.delegate = self;
    
    toolbar.y = self.view.height - toolbar.height;//如果键盘消失后toolbar留在界面底部就用这句
    [self.view addSubview:toolbar];
    
    
    //self.textView.inputView 用来设置键盘
//    self.textView.inputAccessoryView = toolbar;//将工具条添加到键盘上如果键盘消失后toolbar不留在界面上就用这句
    
}
/**
 * 设置导航栏内容
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 2.拼接请求参数
    Account * account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         //NSLog(@"请求成功-%@", responseObject);
         //获取名字
         userModle *user = [userModle objectWithKeyValues:responseObject];
         
         NSString *name = user.name;
         // 标题按钮
        
         NSString *prefix = @"发微博";
         if (name) {
             UILabel *titleView = [[UILabel alloc] init];
             titleView.width = 200;
             titleView.height = 100;
             titleView.textAlignment = NSTextAlignmentCenter;
             // 自动换行
             titleView.numberOfLines = 0;
             titleView.y = 50;
             
             NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
             
             // 创建一个带有属性的字符串（比如颜色属性、字体属性等文字属性）
             NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
             // 添加属性
             [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
             [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
             titleView.attributedText = attrStr;
             self.navigationItem.titleView = titleView;
         } else {
             self.title = prefix;
         }
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"请求失败-%@", error);
         
     }];
    
    
    
}

/**
 * 添加输入控件
 */
- (void)setupTextView
{
    // 在这个控制器中，textView的contentInset.top默认会等于64
    HXTextView *textView = [[HXTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placehoder = @"分享新鲜事...";
    textView.placehoderColor = [UIColor grayColor];
    textView.delegate = self;//监听推拽
    textView.alwaysBounceVertical = YES;//垂直上永远可以拖拽 弹簧效果
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    // 监听文字改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 监听键盘退下通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kayboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
//    //键盘的frame 发生改变时发出通知（位置和尺寸）
//    UIKeyboardWillChangeFrameNotification;
//    UIKeyboardDidChangeFrameNotification;
//    //键盘显示时发出通知
//    UIKeyboardDidShowNotification;
//    UIKeyboardWillShowNotification;
//    //键盘隐藏 时发出通知
//    UIKeyboardWillHideNotification;
//    UIKeyboardDidHideNotification;
//    
}

/**
 UITextField:
 1.文字永远是一行，不能显示多行文字
 2.有placehoder属性设置占位文字
 3.继承自UIControl
 4.监听行为
 1> 设置代理
 2> addTarget:action:forControlEvents:
 3> 通知:UITextFieldTextDidChangeNotification
 
 UITextView:
 1.能显示任意行文字
 2.不能设置占位文字
 3.继承自UIScollView
 4.监听行为
 1> 设置代理
 2> 通知:UITextViewTextDidChangeNotification
 */


#pragma mark - 监听方法
/**
 *  键盘的frame 发生改变时调用
 */
- (void)kayboardWillChangeFrame:(NSNotification *)notification
{
    if (self.switchingKeyboard) return;
    
    NSLog(@"kayboardWillChangeFrame");
    /**
     *  userInfo = { 
     //键盘弹出后的frame
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 308}, {320, 260}},
     //键盘弹出\隐藏的时间
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     //键盘弹出\隐藏的节奏（匀速，先快后慢）
     UIKeyboardAnimationCurveUserInfoKey = 7
     */
    
    NSDictionary *userInfo = notification.userInfo;
    //动画持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        //键盘的y值 keyboardF.origin.y
        self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
    }];
}

/**
 *  取消
 */
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    //发送
    if (self.photosView.photos.count) {//如果 发送的微博有图片
        [self sendWithimage];
    }else{//如果 发送的微博没有图片
        [self sendWithNoimage];
    }
    
    
        // 4.dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  有图片
 */
- (void)sendWithimage
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"status"] = self.textView.text;
    // 3.发送图片
    /**	access_token true string*/
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //拼接文件数据
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        [formData appendPartWithFileData: data name:@"pic" fileName:@"abc.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];

}
/**
 *  无图片
 */
- (void)sendWithNoimage
{
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	pic false binary 微博的配图。*/
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送文字
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}
/**
 * 监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}
#pragma mark - UITextViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];//键盘退下
}
#pragma mark - HXComposeToolbarDelegate
- (void)composeToolbar:(HXComposeToolbar *)toolbar didClickButton:(HXComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case  HXComposeToolbarButtonTypeCamera:// 拍照
            [self openCamera];
            break;
        case HXComposeToolbarButtonTypePicture://相册
            [self openAlbum];
            break;

        case HXComposeToolbarButtonTypeMention://@
            
            NSLog(@"@");
            break;

        case HXComposeToolbarButtonTypeTrend://＃
            
            NSLog(@"＃");
            break;

        case HXComposeToolbarButtonTypeEmotion://表情
            [self switchKayboard];
            break;

        default:
            break;
    }
}



#pragma mark -UIImagePickerControllerDelegate
/**
 *  从UIImagePickerController选择完图片就调用（拍照完毕或者选择相册图片完毕）
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // 添加图片到photosView 中
    [self.photosView addPhoto:image];
    
}



#pragma mark - 其他方法
- (void)openCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {//判断相机是否可用
        UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;//数据来源是照相机
        [self presentViewController:ipc animated:YES completion:nil];
        ipc.delegate = self;
    }
    
}
- (void)openAlbum
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {//判断相机是否可用
        UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//数据来源是照相机
        [self presentViewController:ipc animated:YES completion:nil];
        ipc.delegate = self;
    }
}
- (void)switchKayboard
{
    if (self.textView.inputView == nil)//切换自定义键盘
    {
        
        self.textView.inputView = self.emotionKeyboard;
        //在HXComposeToolbar 中的showEmotionbutton判断是否要更改图片
        self.toolbar.showEmotionbutton = YES;
        
    }
    else//切换系统自带键盘
    {
        self.toolbar.showEmotionbutton = NO;
        self.textView.inputView = nil;//为空时 就自动 切换为系统自带键盘
    }
    self.switchingKeyboard = YES;
    //退出键盘
    [self.textView endEditing:YES];
    
    //也可以将它放在全局队列 开启新线程 [self.textView becomeFirstResponder];有延迟效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
        
        self.switchingKeyboard = NO;
        
    });
    
    
}



@end
