//
//  UIImage+WHandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import <UIKit/UIKit.h>

@interface UIImage (WHandler)
#pragma mark - 生成图片
/**
 生成单色图片

 @param color 图片的颜色
 @param size 图片的尺寸
 @return 返回图片
 */
+ (UIImage *) imageWithColor:(UIColor *)color
                        size:(CGSize)size;


/**
 生成条形码

 @param barCode 条形码
 @param size 尺寸
 @return 返回图片
 */
+ (UIImage *) barCodeImageWithBarCode:(NSString *)barCode
                                 size:(CGSize)size;


/**
 生成二维码

 @param QRCode 二维码
 @param size 尺寸
 @return 返回图片
 */
+ (UIImage *) QRCodeImageWithQRCode:(NSString *)QRCode
                               size:(CGSize)size;

/**
 全屏截图

 @return 返回截图图片
 */
+ (UIImage *)getScreenShot;


#pragma mark - 调整尺寸
/**
 重新调整图片尺寸

 @param size 要缩小的尺寸
 @return 返回缩小后的尺寸
 */
- (UIImage *)reszie:(CGSize)size;


/**
 调整生成的图片的大小

 @param image 要缩小的图片
 @param size 要缩小的尺寸
 @return 返回缩小后的尺寸
 */
+ (UIImage *) resizeCodeImage:(CIImage *)image
                     withSize:(CGSize)size;


#pragma mark - 压缩图片
/**
 压缩图片到指定文件大小

 @param size 要缩小的尺寸
 @return 返回缩小后的尺寸
 */
- (NSData *) compresstoMaxDataSizeKBytes:(CGFloat)size;


#pragma mark - 对图片进行模糊处理

    // CIGaussianBlur ---> 高斯模糊

    // CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)

    // CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)

    // CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)

    // CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
+ (UIImage *)blurWithOriginalImage:(UIImage *)image
                          blurName:(NSString *)name
                            radius:(NSInteger)radius;


/**
 *  调整图片饱和度, 亮度, 对比度
 *
 *  @param image      目标图片
 *  @param saturation 饱和度
 *  @param brightness 亮度: -1.0 ~ 1.0
 *  @param contrast   对比度
 *
 */
+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast;
@end
