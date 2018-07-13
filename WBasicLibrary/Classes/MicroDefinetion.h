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

#import "NSDate+Whandler.h"     //日期分类
#import "NSObject+Whandler.h"   //运行时分类

//=======================================================================================
#pragma mark - 常用的宏定义
//常用的宏定义
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//#define NavBarHeight [WTool getNavbarHeight]
//#define BottomHeight [WTool getBottomHeight]
//#define isIPHoneX [WTool isiPhoneX]

#ifdef DEBUG
#define WLOG(...) NSLog(__VA_ARGS__);
#define WLOG_METHOD NSLog(@"%s", __func__);
#else
#define WLOG(...);
#define WLOG_METHOD;
#endif

#define VIEW_WITH_RECT(x,y,width,height) [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)]
#define LABEL_WITH_RECT(x,y,width,height) [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)]
#define IMAGE_WITH_RECT(x,y,width,height) [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)]

//是否要显示导航页
#define SHOWNAVPAGE @"SHOWNAVPAGE"

//升级成功提示
#define UPDATE_LATER @"UPDATE_LATER"

//=======================================================================================
#program mark - 常用方法

#define NavBarHeight [WTool getNavbarHeight]
#define BottomHeight [WTool getBottomHeight]
#define isIPHoneX [WTool isiPhoneX]

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


//=======================================================================================
#program mark - 显示消息

#define SHOW_SUCCESS_MESSAGE(_MESSAGE_) [MessageTool showSuccessMessage:_MESSAGE_];
#define SHOW_INFO_MESSAGE(_MESSAGE_) [MessageTool showInfoMessage:_MESSAGE_];
#define SHOW_ERROR_MESSAGE(_MESSAGE_) [MessageTool showErrorMessage:_MESSAGE_];

#endif /* Definetion_h */
