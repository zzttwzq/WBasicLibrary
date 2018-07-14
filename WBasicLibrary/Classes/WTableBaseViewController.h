//
//  WTableBaseViewController.h
//  Pods
//
//  Created by 吴志强 on 2018/3/10.
//

#import "WBaseViewController.h"
#import "WRefreshView.h"
#import "WLoadStatueView.h"
#import "WTool.h"

@interface WTableBaseViewController : WBaseViewController
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *tableHeaderView;
@property (nonatomic,strong) UIView *tableFooterView;

@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,assign) NSInteger firstPage;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger total;

@property (nonatomic,strong) WLoadStatueView *loadStatueView;
/**
 不显示加载中的提示视图
 */
@property (nonatomic,assign) BOOL disableRequestingView;

/**
 取消网络错误提示视图
 */
@property (nonatomic,assign) BOOL disableLoadStatueView;

/**
 table头部刷新视图
 */
@property (nonatomic,assign) BOOL disableTableRefreshHeader;

/**
 table低部刷新视图
 */
@property (nonatomic,assign) BOOL disableTableRefreshFooter;

/**
 取消首次下拉刷新的效果
 */
@property (nonatomic,assign) BOOL disableFirstTableRefreshHeaderAnimation;

/**
 允许table滑动的时候 隐藏键盘
 */
@property (nonatomic,assign) BOOL enableTableScrollCancelEditing;

/**
 刷新数据
 */
-(void)tableReloadData;


/**
 刷新数据
 */
-(void)getList;


/**
 准备请求数据
 @param callBack 网络请求回调
 */
-(void)prepareNetWorkWithCallBack:(BlankBlock)callBack;


/**
 处理刷新状态（包括刷新头，刷新底部，没有数据界面显示等）

 @param error 网络请求的错误
 */
-(void)handleStateWithError:(NSError *)error;


@end
