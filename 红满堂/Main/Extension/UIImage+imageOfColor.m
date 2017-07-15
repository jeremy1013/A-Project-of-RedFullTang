//
//  UIImage+imageOfColor.m
//  NanYueTong
//
//  Created by 郑钦洪 on 15/11/20.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UIImage+imageOfColor.h"

@implementation UIImage (imageOfColor)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)navigationBarColorImage{
    return [self imageWithColor:rgbColor(60, 145, 247)];
}

+ (UIImage *)imageWithRightCorners:(CGFloat)radius size:(CGSize)size color:(UIColor *)color{
    // 描述矩形
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, size.width, size.height) byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii: CGSizeMake(radius, radius)];
    [rectanglePath closePath];
    [color setFill];
    [rectanglePath fill];
    
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    // 抗锯齿
    return [theImage antiAlias];
}

+ (UIImage *)imageWithLeftCorners:(CGFloat)radius size:(CGSize)size color:(UIColor *)color{
    // 描述矩形
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, size.width, size.height) byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii: CGSizeMake(radius, radius)];
    [rectanglePath closePath];
    [color setFill];
    [rectanglePath fill];
    
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    // 抗锯齿
    return [theImage antiAlias];
}


// 抗锯齿
- (UIImage *)antiAlias
{
    CGFloat border = 1.0f;
    CGRect rect = CGRectMake(border, border, self.size.width-2*border, self.size.height-2*border);
    
    UIImage *img = nil;
    
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width,rect.size.height));
    [self drawInRect:CGRectMake(-1, -1, self.size.width, self.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.size);
    [img drawInRect:rect];
    UIImage* antiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiImage;
}

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *) name
{
    UIImage *normal = [UIImage imageNamed:name];
    
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h,w,h,w)];
}

@end
