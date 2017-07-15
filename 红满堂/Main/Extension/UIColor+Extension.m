//
//  UIColor+Extension.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/6.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+(UIColor *)colorWithOffset:(CGFloat)offset{
    if (offset <= MainScreenWidth) {
    //251  24  39
    //26    166   214
    double fenshuR = (26 - 251) / MainScreenWidth;
    double fenshuG = (166 - 24) / MainScreenWidth;
    double fenshuB = (214 - 39) / MainScreenWidth;
    
    double fen = offset ;
    
//    HMTLog(@"%f,%f,%f",251 + fenshuR * fen,24 + fenshuG * fen,39 + fenshuB * fen);
    
    NSInteger red = 251 + fenshuR * fen;
    NSInteger green = 24 + fenshuG * fen;
    NSInteger blue = 39 + fenshuB * fen;
    
    
        //        self.tabbarVc.tabbar.backgroundColor = [UIColor colorWithRed:251 + fenshuR * fen green:24 + fenshuG * fen blue:39 + fenshuB * fen alpha:1];
//        self.tabbarVc.tabbarColor = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1];
        return rgbColor(red, green, blue);
    }else{
        //26  166  214
        //120    84   177
        double fenshuR = (120 - 26) / MainScreenWidth;
        double fenshuG = (84 - 166) / MainScreenWidth;
        double fenshuB = (177 - 214) / MainScreenWidth;
        
        double fen = offset - MainScreenWidth;
        
//        HMTLog(@"%f,%f,%f",26 + fenshuR * fen,166 + fenshuG * fen,214 + fenshuB * fen);
        
        NSInteger red = 26 + fenshuR * fen;
        NSInteger green = 166 + fenshuG * fen;
        NSInteger blue = 214 + fenshuB * fen;
        return rgbColor(red, green, blue);
    }
    
    
}
@end
