//
//  WMessage.m
//  Pods
//
//  Created by 吴志强 on 2018/7/9.
//

#import "WMessage.h"

@interface WMessage ()

//@property (nonatomic,strong) WLoadingView *loadingView;

@end

@implementation WMessage
/**
 吐司消息

 @param toastMessage 要显示的吐司消息
 */
+(void)showToast:(NSString *)toastMessage;
{
    [self showMessage:toastMessage fromBottomPosition:FYMESSAGE_POSITION_TYPE_BOTTOM isWhite:NO Animat:NO];
}


/**
 toast消息

 @param message 消息
 @param position 位置
 @param isWhite 是否是白色
 @param Animat 是否有动画
 */
+(void)showMessage:(NSString *)message fromBottomPosition:(FYMESSAGE_POSITION)position isWhite:(BOOL)isWhite Animat:(BOOL)Animat;
{
    if (![message isKindOfClass:[NSString class]]) {
        return;
    }

    if (message.length == 0) {
        return;
    }

    UIWindow * window = [UIApplication sharedApplication].keyWindow;

    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGSize LabelSize = [message boundingRectWithSize:CGSizeMake(ScreenWidth-20, ScreenHeight-80) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

        //显示的位置------------//------------//------------//------------//------------//------------//------------//
    float labWidth = LabelSize.width+20;
    float labHeight = LabelSize.height+20;
    float labX = window.center.x - labWidth/2;
    float labY = 0;

    int animationType = 0;
    if (position == FYMESSAGE_POSITION_TYPE_TOP) {

        labY = 30 + labHeight/2;
        animationType = FYMESSAGE_ANIMATION_TYPE_SLIPFROMTOP;

    }else if (position == FYMESSAGE_POSITION_TYPE_MIDDLE) {

        labY = window.center.y - labHeight/2;
        animationType = FYMESSAGE_ANIMATION_TYPE_FADE;

    }else if (position == FYMESSAGE_POSITION_TYPE_BOTTOM) {

        labY = window.frame.size.height - labHeight - 80;
        animationType = FYMESSAGE_ANIMATION_TYPE_SLIPFROMBOTTOM;

    }else{

        labY = position;
        if (position <= window.center.x) {

            animationType = FYMESSAGE_ANIMATION_TYPE_SLIPFROMTOP;
        }else{

            animationType = FYMESSAGE_ANIMATION_TYPE_SLIPFROMBOTTOM;
        }
    }

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labX, 0, labWidth, labHeight)];

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:message];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.firstLineHeadIndent = 6;
    style.tailIndent = -10; //设置与尾部的距离
    style.headIndent = style.firstLineHeadIndent;
    style.alignment = NSTextAlignmentLeft;
    [attrString addAttribute:NSParagraphStyleAttributeName value:style  range:NSMakeRange(0, message.length)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,message.length)];//设置字体
    label.attributedText = attrString;

    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:70/255.00f green:70/255.00f blue:70/255.00f alpha:0.8];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;//自动换行
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    [window addSubview:label];

        //整体颜色------------//------------//------------//------------//------------//------------//------------//
    if (isWhite == YES) {
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
    }


        //动画，，后期会增加block自定义动画------------//------------//------------//------------//------------//------------//------------//
    if (Animat == NO) {

        animationType = FYMESSAGE_ANIMATION_TYPE_FADE;
    }


        //显示动画------------//------------//------------//------------//------------//------------//------------//
    if (animationType == FYMESSAGE_ANIMATION_TYPE_FADE) {

        label.frame = CGRectMake(labX, labY, labWidth, labHeight);
        label.alpha = 0;

        [UIView animateWithDuration:0.3 animations:^{
            label.alpha = 1;
        }];

    }else if (animationType == FYMESSAGE_ANIMATION_TYPE_SLIPFROMTOP) {

        label.frame = CGRectMake(labX, 0, labWidth, labHeight);

        [UIView animateWithDuration:0.3 animations:^{

            label.frame = CGRectMake(labX, labY, labWidth, labHeight);
        }];

    }else if (animationType == FYMESSAGE_ANIMATION_TYPE_SLIPFROMBOTTOM) {

        label.frame = CGRectMake(labX, window.frame.size.height, labWidth, labHeight);

        [UIView animateWithDuration:0.3 animations:^{

            label.frame = CGRectMake(labX, labY, labWidth, labHeight);
        }];
    }

    __block int timeout = 2.5; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置

                [UIView animateWithDuration:0.3 animations:^{

                    label.alpha = 0;
                } completion:^(BOOL finished) {

                    [label removeFromSuperview];
                }];
            });
        }else{

            dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置


            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


#pragma mark - 弹框消息
/**
 生成系统提示，可以是alert 也可以是 actionsheet

 @param alertType 消息展现形式（alertview，actionsheet）
 @param target 在哪个控制器
 @param title 标题
 @param message 消息
 @param actions 按钮数组
 @param comfirmAction 确定点击事件
 */
+(void)showSystemAlertWithalertType:(UIAlertControllerStyle)alertType
                             target:(UIViewController *)target
                              Title:(NSString *)title
                            message:(NSString *)message
                            actions:(NSArray *)actions
                      comfirmAction:(void(^)(UIAlertAction *action))comfirmAction;
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertType];

        //修改标题的内容，字号，颜色。使用的key值是“attributedTitle”
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:message];
    [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[hogan string] length])];
    [alertController setValue:hogan forKey:@"attributedMessage"];

        //其他按钮
    for (int i = 0; i < actions.count; i++) {

        [alertController addAction:actions[i]];
    }
    [target presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 显示alert提示框
/**
 显示弹出提示 只有确定和取消按钮，颜色是系统默认的颜色

 @param title 标题
 @param target 在哪个控制器
 @param enableCancelBtn 显示取消按钮
 @param message 消息内容
 @param comfirmAction 确定点击事件
 */
+(void)showAlertWithTitle:(NSString *)title
                   target:(UIViewController *)target
          enableCancelBtn:(BOOL)enableCancelBtn
                  message:(NSString *)message
            comfirmAction:(void(^)(UIAlertAction *action))comfirmAction;
{
    NSMutableArray *array = [NSMutableArray array];
    if (enableCancelBtn) {
        WMessageAction *actionCancel = [WMessageAction actionWithText:@"取消" textColor:nil btnclick:comfirmAction];
        [array addObject:actionCancel];
    }
    WMessageAction *actionConfirm = [WMessageAction actionWithText:@"确定" textColor:nil btnclick:comfirmAction];
    [array addObject:actionConfirm];

    [self showSystemAlertWithalertType:UIAlertControllerStyleAlert
                                target:target ? target : [UIApplication sharedApplication].keyWindow.rootViewController
                                 Title:title
                               message:message
                               actions:array
                         comfirmAction:comfirmAction];
}


/**
 显示弹出提示（可以改按钮个数，按钮颜色）

 @param target 在哪个控制器
 @param title 消息内容
 @param message 消息内容
 @param actions 按钮名称
 @param colors 按钮颜色
 @param comfirmAction 确定点击事件
 */
+(void)showAlertWithTarget:(UIViewController *)target
                     title:(NSString *)title
                   message:(NSString *)message
                   actions:(NSArray *)actions
                    colors:(NSArray *)colors
             comfirmAction:(void(^)(UIAlertAction *action))comfirmAction;
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<actions.count; i++) {

        NSString *actionName = actions[i];
        UIColor *actionColor;
        if (colors.count > i) {
            actionColor = colors[i];
        }

        WMessageAction *actionConfirm = [WMessageAction actionWithText:actionName textColor:actionColor btnclick:comfirmAction];
        [array addObject:actionConfirm];
    }

    [self showSystemAlertWithalertType:UIAlertControllerStyleAlert
                                target:target ? target : [UIApplication sharedApplication].keyWindow.rootViewController
                                 Title:title
                               message:message
                               actions:array
                         comfirmAction:comfirmAction];
}


#pragma mark - 显示actionsheet提示框
/**
 显示actionsheet 可以自定义按钮个数 但是颜色不能更改

 @param title 标题
 @param target 在哪个控制器
 @param enableCancelBtn 在哪个控制器
 @param message 消息内容
 @param comfirmText 确定的消息
 @param actionNames 确定的消息
 @param comfirmAction 确定点击事件
 */
+(void)showActionSheetWithTitle:(NSString *)title
                         target:(UIViewController *)target
                enableCancelBtn:(BOOL)enableCancelBtn
                        message:(NSString *)message
                    comfirmText:(NSString *)comfirmText
                    actionNames:(NSArray *)actionNames
                  comfirmAction:(void(^)(UIAlertAction *action))comfirmAction;
{
    NSMutableArray *array = [NSMutableArray array];
    if (enableCancelBtn) {
        WMessageAction *actionCancel = [WMessageAction actionWithText:@"取消" textColor:nil btnclick:comfirmAction];
        [array addObject:actionCancel];
    }
    WMessageAction *actionConfirm = [WMessageAction actionWithText:comfirmText textColor:nil btnclick:comfirmAction];
    [array addObject:actionConfirm];

    [self showSystemAlertWithalertType:UIAlertControllerStyleActionSheet
                                target:target ? target : [UIApplication sharedApplication].keyWindow.rootViewController
                                 Title:title
                               message:message
                               actions:array comfirmAction:comfirmAction];
}


@end

#pragma mark - WMessageAction 消息的子类

@implementation WMessageAction
/**
 初始化方法

 @param text 显示的文字
 @param textColor 文字的颜色
 @param btnclick 按钮点击事件回调
 @return 返回实例化的消息按钮对象
 */
+(WMessageAction *)actionWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                         btnclick:(void(^)(UIAlertAction *action))btnclick;

{
    int style = UIAlertActionStyleDefault;
    if ([text isEqualToString:@"取消"]) {

        style = UIAlertActionStyleCancel;
    }
    WMessageAction *action = [WMessageAction actionWithTitle:text style:style handler:btnclick];
    [action setValue:textColor forKey:@"_titleTextColor"];

    return action;
}

@end
