//
//  WWebViewController.h
//  wzqproject
//
//  Created by 吴志强 on 2017/12/13.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WLoadStatueView.h"
#import "Definitions.h"
#import "WTool.h"
#import "WRefreshView.h"

@interface WWebViewController : UIViewController<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UIScrollViewDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,copy) NSString *urlString;   //url
@property (nonatomic,assign) BOOL disableIndicator;//取消顶部导航条
@property (nonatomic,assign) BOOL showNavBar;   //取消隐藏导航栏
@property (nonatomic,assign) BOOL statuBarWhiteColor;//白色的状态条
@property (nonatomic,assign) BOOL clearCache;
@property (nonatomic,assign) BOOL enableNewWindow;
@property (nonatomic,assign) BOOL disAbleRefresh;

@property (nonatomic,strong) WLoadStatueView *loadStatueView;
@property (nonatomic,assign) BOOL selfRefreshing;
@property (nonatomic,assign) BOOL showLeftBtn;

/**
 显示返回取消的按钮(present出来的页面使用)
 */
- (void)showDismissBtn;


/**
 初始化webview
 */
-(void)initWebView;


/**
 请求网络

 @param url 要加载的url字符串
 */
-(void)loadRequestURLString:(NSString *)url;


/**
 添加监听脚本

 @param scriptNameArray 监听脚本数组
 */
-(void)addScriptHandlerWithScriptNameArray:(NSArray *)scriptNameArray;


//刷新自己
-(void)refreshWebView;
@end
