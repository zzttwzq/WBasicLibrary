//
//  WMessage.h
//  Pods
//
//  Created by 吴志强 on 2018/7/9.
//

#import <UIKit/UIKit.h>
#import "MicroDefinetion.h"

//toast位置
typedef NS_ENUM(NSInteger,FYMESSAGE_POSITION) {
    FYMESSAGE_POSITION_TYPE_TOP,
    FYMESSAGE_POSITION_TYPE_MIDDLE,
    FYMESSAGE_POSITION_TYPE_BOTTOM
};

//toast动画
typedef NS_ENUM(NSInteger,FYMESSAGE_ANIMATION) {
    FYMESSAGE_ANIMATION_TYPE_FADE,
    FYMESSAGE_ANIMATION_TYPE_SLIPFROMTOP,
    FYMESSAGE_ANIMATION_TYPE_SLIPFROMBOTTOM
};

@interface WMessage : NSObject

#pragma mark - 显示吐司消息
/**
 吐司消息

 @param toastMessage 要显示的吐司消息
 */
+(void)showToast:(NSString *)toastMessage;


/**
 toast消息

 @param message 消息
 @param position 位置
 @param isWhite 是否是白色
 @param Animat 是否有动画
 */
+(void)showMessage:(NSString *)message
fromBottomPosition:(FYMESSAGE_POSITION)position
           isWhite:(BOOL)isWhite Animat:(BOOL)Animat;


#pragma mark - 显示系统消息
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

@end


@interface WMessageAction : UIAlertAction
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
@end
