//
//  WBaseViewController.m
//  wzqFundation
//
//  Created by 吴志强 on 2017/11/3.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import "WBaseViewController.h"
#import "MessageTool.h"

@interface WBaseViewController()<SKStoreProductViewControllerDelegate>

@property (nonatomic,copy) NSString *appid;
@property (nonatomic,strong) UITapGestureRecognizer *tap;

@end

@implementation WBaseViewController

#pragma mark - view生命周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //UIKeyboardWillShowNotification 键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //UIKeyboardWillHideNotification 键盘隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //1.设置背景色
    self.view.backgroundColor = [UIColor whiteColor];

    //2.设置触摸取消编辑
    self.enableTouchCancelEditing = YES;

    if (@available(iOS 11.0, *)) {}else{

        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEnableTouchCancelEditing:(BOOL)enableTouchCancelEditing
{
    _enableTouchCancelEditing = enableTouchCancelEditing;
    if (_enableTouchCancelEditing) {

        [self cancelTouch];
    }else{

        [self.view removeGestureRecognizer:_tap];
    }
}

- (void) setShowLeftBtn:(BOOL)showLeftBtn
{
    _showLeftBtn = showLeftBtn;
    if (_showLeftBtn) {

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_back_icon_40x20"] style:0 target:self action:@selector(back)];
    }else{

        self.navigationItem.leftBarButtonItem = nil;
    }
}


-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 键盘
-(void)cancelTouch
{
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    _tap.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:_tap];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)aNotification;
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];

    self.inputListView.height = self.view.frame.size.height-keyboardRect.size.height;
    self.inputListView.scroll.height = self.view.frame.size.height-keyboardRect.size.height;
}

- (void)keyboardWillHide:(NSNotification *)aNotification;
{

    self.inputListView.height = self.inputViewHeight;
    self.inputListView.scroll.height = self.inputViewHeight;
}


@end
