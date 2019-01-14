//
//  Definetion.h
//  Pods
//
//  Created by 吴志强 on 2018/7/9.
//

#ifndef MicroDefinetion_h
#define MicroDefinetion_h

//系统框架
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark - 常用分类
//系统框架
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>

#import "Reachability.h"             //网络库
#import "NSDate+Whandler.h"          //日期分类
#import "NSObject+Whandler.h"        //运行时分类
#import "UIView+WHandler.h"          //view扩展分类
#import "UIColor+Whandler.h"         //color扩展分类
#import "NSData+AES256_.h"           //data的分类
#import "NSData+Base64_.h"           //data的分类
#import "NSString+WHandler.h"        //字符串的分类
#import "NSMutableArray+WHandler.h"  //数组的分类
#import "UILabel+WHandler.h"         //标签的分类
#import "UIImage+WHandler.h"         //image的分类
#import "UIViewController+BasicHandler.h"
#import "UIViewController+WebHandler.h"
#import "UIViewController+TableHandler.h"
#import "UIAlertController+WHandler.h"

//==================================== 常用的宏定义 ==========================================
#pragma mark - 常用的宏定义
//==================================== 常用的宏定义 ==========================================
#define ScreenWidth             [UIScreen mainScreen].bounds.size.width
#define ScreenHeight            [UIScreen mainScreen].bounds.size.height

#define Adjust_Width(x) ScreenWidth / 375 * x

#define KeyWindow               [UIApplication sharedApplication].keyWindow
#define keyViewController               [UIApplication sharedApplication].keyWindow.rootViewController

#define IS_IPHONE_4             [WTool is_Iphone_4]
#define IS_IPHONE_5             [WTool is_Iphone_5]
#define IS_IPHONE_6             [WTool is_Iphone_6]
#define IS_IPHONE_6p            [WTool is_Iphone_6p]
#define IS_IPHONE_X             [WTool is_Iphone_x]

#define Height_NavContentBar    44.0f
#define Height_StatusBar        (IS_IPHONE_X==YES)?44.0f: 20.0f
#define Height_NavBar           (IS_IPHONE_X==YES)?88.0f: 64.0f
#define Height_TabBar           (IS_IPHONE_X==YES)?83.0f: 49.0f

#ifdef DEBUG

    #define WLOG(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

    #define WJSON_LOG(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:__VA_ARGS__ options:kNilOptions error:nil] encoding:NSUTF8StringEncoding] UTF8String]);

    #define WLOG_METHOD         NSLog(@"%s", __func__);
#else

    #define WLOG(...);
    #define WJSON_LOG;
    #define WLOG_METHOD;
#endif

//显示调试消息
#define DEBUG_LOG(TARGET,MESSAGE) WLOG(@"<! 警告 !> %@ %@",TARGET,MESSAGE)

#define VIEW_WITH_RECT(x,y,width,height) [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
#define LABEL_WITH_RECT(x,y,width,height) [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
#define IMAGE_WITH_RECT(x,y,width,height) [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
#define TEXTFIELD_WITH_RECT(x,y,width,height) [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
#define BUTTON_WITH_RECT(x,y,width,height) [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];

#define VIEW [[UIView alloc] init];
#define LABEL [[UILabel alloc] init];
#define IMAGE [[UIImageView alloc] init];
#define TEXTFIELD [[UITextField alloc] init];
#define BUTTON [UIButton buttonWithType:UIButtonTypeCustom];

//是否要显示导航页
#define SHOWNAVPAGE @"SHOWNAVPAGE"

//升级成功提示
#define UPDATE_LATER @"UPDATE_LATER"


//================================== 常用方法 ==============================================
#pragma mark - 常用的宏定义
//================================== 常用方法 ==============================================
#define NavBarHeight [WTool getNavbarHeight]
#define BottomHeight [WTool getBottomHeight]

//获取颜色
#define RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define COLORWITHHEX(HEX) [UIColor colorWithHexString:[NSString stringWithFormat:@"#%@",HEX]]
#define WINDOW_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]

//弱引用
#define WEAK_SELF(Class) typeof(Class *)weakSelf = self;

//拨打电话
#define CALL_PHONE_NUM(NUM) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:/%@",NUM]]];

//发送通知
#define POST_NOTIFICATION(NAME) [[NSNotificationCenter defaultCenter] postNotificationName:NAME object:nil];

//注册通知
#define REGISTER_NOTIFICATION(SELECTOR,NAME) [[NSNotificationCenter defaultCenter] addObserver:self selector:SELECTOR name:NAME object:nil];

//移除通知
#define REMOVE_NOTIFICATION(NAME) [[NSNotificationCenter defaultCenter] removeObserver:self name:NAME object:nil]

//弧度转角度
#define RADIANS_TO_DEGREES(radians) (radians * (180.0 / M_PI))

#define IMAGE_NAMED(A) [UIImage imageNamed:A]
#define URL_WITH_STRING(A) [NSURL URLWithString:A]
#define Adjust_Font(float) [UIFont systemFontOfSize:float * (ScreenHeight == 812.0 ? 667.0 : ScreenHeight) / 667.0]

//================================== block回调 ==============================================
#pragma mark - 常用的宏定义
//================================== block回调 ==============================================
//返回空的回调
typedef void (^BlankBlock)(void);
//返回状态
typedef void (^StateBlock)(BOOL state);
//返回字符串
typedef void (^StringBlock)(NSString * _Nullable string);
//返回int 数据
typedef void (^CountBlock)(int count);
//返回float 数据
typedef void (^floatCallBack)(float update);
//图片回调
typedef void (^ImageBlock)(UIImage * _Nullable image);
//按钮回调
typedef void (^BtnBlock)(UIButton * _Nullable btn);
//按钮回调
typedef void (^Array_Block)(NSArray *array);
//按钮回调
typedef void (^ButtonBlock)(UIButton *btn);






/**
 app启动环境配置，包括数据库配置，路由配置，网络配置，进入页面判定，引导图配置

 @param storageConfigClassName 数据库配置
 @param routerConfigClassName 路由配置
 @param networkConfigClassName 网络配置
 @param userClassName 用户类名
 @param tabbarClassName tabbar类名
 @param loginClassName 登录类名
 @param iphonexLanuchScreen iphonex启动页图片数组
 @param iphoneScreen iphone启动页图片数组
 @return 无
 */
#define appLanuchConfig(ShareConfigClassName,HUDConfigClassName,storageConfigClassName,routerConfigClassName,networkConfigClassName,userClassName,tabbarClassName,loginClassName) \
\
if (@available(ios 11.0, *)) {[UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} \
\
self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];\
\
\
[NSClassFromString(ShareConfigClassName) configShare]; \
\
[NSClassFromString(HUDConfigClassName) configHUD]; \
\
[NSClassFromString(storageConfigClassName) configLocalStorage]; \
\
[NSClassFromString(routerConfigClassName) configGlobalRouters]; \
\
[NSClassFromString(networkConfigClassName) configNetworking]; \
\
\
\
if ([NSClassFromString(userClassName) isUserLogined]) {self.window.rootViewController = [NSClassFromString(tabbarClassName) new];}\
\
else{self.window.rootViewController = [NSClassFromString(loginClassName) new];} \
\
[self.window makeKeyAndVisible];\


#endif /* Definetion_h */
