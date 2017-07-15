//
//  UIImage+imageOfColor.h
//  NanYueTong
//
//  Created by 郑钦洪 on 15/11/20.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (imageOfColor)
/**
 *  根据传入的颜色，生成对应的图片
 *
 *  @param color UIColor对象 需要生成颜色
 *
 *  @return 颜色对应的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)navigationBarColorImage;

/**
 *  返回一张带有左边圆角的图片
 *
 *  @param radius 圆角率
 *  @param size   大小
 *  @param color  颜色
 *
 *  @return 左上角和左下角带圆角的图片
 */
+ (UIImage *)imageWithLeftCorners:(CGFloat)radius size:(CGSize)size color:(UIColor *)color;

/**
 *  返回一张带有右边圆角的图片
 *
 *  @param radius 圆角率
 *  @param size   大小
 *  @param color  颜色
 *
 *  @return 右上角和右下角带圆角的图片
 */
+ (UIImage *)imageWithRightCorners:(CGFloat)radius size:(CGSize)size color:(UIColor *)color;

/**
 *  返回对应大小、颜色及圆角率的图片
 *
 *  @param color  颜色
 *  @param size   大小
 *  @param radius 突起的圆角
 *
 *  @return UIImage
 */
+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius;

/**
 *  返回一张拉伸的图片
 *
 *  @param name 需要拉伸的图片名称
 *
 *  @return 返回处理后的图片
 */
+ (UIImage *)resizableImage:(NSString *) name;

@end
