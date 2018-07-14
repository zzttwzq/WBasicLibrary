//
//  WTableBaseViewController.m
//  Pods
//
//  Created by 吴志强 on 2018/3/10.
//

#import "WTableBaseViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "UIScrollView+MJExtension.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"

@interface WTableBaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) BOOL isFirst;

@end

@implementation WTableBaseViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _page = 0;
    _total = 0;
    _firstPage = 0;
    self.listArray = [NSMutableArray array];

    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavBarHeight)];
    _table.showsVerticalScrollIndicator = NO;
    _table.showsHorizontalScrollIndicator = NO;
    _table.delegate = self;
    _table.dataSource = self;
    _table.tableFooterView = [UIView new];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];

    //添加加载等待视图
    self.disableLoadStatueView = NO;
    self.disableTableRefreshHeader = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 设置方法
///**
// 设置
//
// @param noDataView 设置没有数据的视图
// */
//-(void)setNoDataView:(UIView *)noDataView
//{
//    [_noDataView removeFromSuperview];
//
//    _noDataView = noDataView;
//    [self.view addSubview:_noDataView];
//}


/**
 设置加载出错view

 @param loadStatueView 加载出错view
 */
-(void)setLoadStatueView:(WLoadStatueView *)loadStatueView
{
    [_loadStatueView removeFromSuperview];

    _loadStatueView = loadStatueView;
    [self.view addSubview:_loadStatueView];
}


/**
 设置禁用加载出错的视图

 @param disableLoadStatueView 是否要禁用
 */
-(void)setDisableLoadStatueView:(BOOL)disableLoadStatueView
{
    _disableLoadStatueView = disableLoadStatueView;

    if (disableLoadStatueView) {

        [_loadStatueView removeFromSuperview];
        _loadStatueView = nil;
    }else{

        WEAK_SELF(WTableBaseViewController);
        _loadStatueView = [[WLoadStatueView alloc] initWithLogoImgName:nil];
        [_loadStatueView setLogoImgSize:CGSizeMake(ScreenWidth*0.35, ScreenWidth*0.35)];
        [_loadStatueView setContentViewOffset:ScreenHeight*0.14];
        _loadStatueView.refresh = ^(BOOL state) {

            [weakSelf getList];
        };
        _loadStatueView.showInView = self.view;
    }
}


/**
 是否取消刷新头

 @param disableTableRefreshHeader 是否取消，默认添加
 */
-(void)setDisableTableRefreshHeader:(BOOL)disableTableRefreshHeader
{
    _disableTableRefreshHeader = disableTableRefreshHeader;
    if (disableTableRefreshHeader) {

        self.table.mj_header = nil;
        
        [self getList];
    }else{

        //添加下拉刷新
        self.table.mj_header = [WRefreshView initHeaderWithController:self action:@selector(getList)];

        //开始刷新请求数据
        if (_disableFirstTableRefreshHeaderAnimation) {

            [self getList];
        }else{

            [self.table.mj_header beginRefreshing];
        }
    }
}


/**
 是否取消刷新底部

 @param disableTableRefreshFooter 是否取消，默认添加
 */
-(void)setDisableTableRefreshFooter:(BOOL)disableTableRefreshFooter
{
    _disableTableRefreshFooter = disableTableRefreshFooter;
    if (disableTableRefreshFooter) {

        self.table.mj_footer = nil;
    }else{

        //添加下拉刷新
        self.table.mj_footer = [WRefreshView initFooterWithController:self action:@selector(getList)];
    }
}


/**
 设置数据源

 @param listArray 数据源
 */
-(void)setListArray:(NSMutableArray *)listArray
{
    _listArray = listArray;
    [self tableReloadData];
}


/**
 刷新数据
 */
-(void)tableReloadData;
{
//    [self.table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [self.table reloadData];
}


/**
 刷新数据
 */
-(void)getList;
{
    [self.table.mj_header endRefreshing];
}


/**
 准备请求数据
 @param callBack 网络请求回调
 */
-(void)prepareNetWorkWithCallBack:(BlankBlock)callBack;
{
    //判断网络
    if ([AppInfo getInstance].netState == WNetStatue_UNReach) {

        _loadStatueView.type = WViewLoadingType_NoNetWork;
    }else{

        //当重新加载的时候，就清空数组
        if (self.firstPage == self.page) {
            [self.listArray removeAllObjects];
        }

        if (callBack) {
            callBack();
        }
    }
}


/**
 处理刷新状态（包括刷新头，刷新底部，没有数据界面显示等）

 @param error 网络请求的错误
 */
-(void)handleStateWithError:(NSError *)error;
{
    //取消刷新等待
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];

    //判断网络是否出错
    if (error) {
        self.page --;
        self.loadStatueView.type = WViewLoadingType_LoadError;
    }

    //判断数据是否加载完
    if (self.listArray.count == 0) {

        self.loadStatueView.type = WViewLoadingType_NoData;
    }
    else if (self.listArray.count >= self.total) {

        self.table.mj_footer = nil;
    }else{

        self.table.mj_footer = [WRefreshView initFooterWithController:self action:@selector(getList)];
    }

    //请求结束加上mjfooter
    if (!self.isFirst) {
        self.isFirst = YES;

        self.disableTableRefreshFooter = self.disableTableRefreshFooter;
    }
}


#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (self.listArray.count > 0) {

        self.loadStatueView.type = WViewLoadingType_None;
    }else{

        self.loadStatueView.type = WViewLoadingType_NoData;
    }

    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellid =@"cellid";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    cell.detailTextLabel.text = @"asdfasd";
    cell.textLabel.text = @"标题";

    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    //  分割线去掉左边15个像素
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){

        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]){

        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_enableTableScrollCancelEditing) {
        [self.view endEditing:YES];
    }
}
@end
