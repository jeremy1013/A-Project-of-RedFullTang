//
//  NSString+Extension.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
+(NSString *)subStringWithName:(NSString *)name inUrl:(NSString *)url{
    NSString *returnString;
    NSRange nameRange = [url rangeOfString:[NSString stringWithFormat:@"%@=",name]];
    if (nameRange.length != 0) {
        // 截取code=后面&expires_in前面的参数值
        NSInteger fromIndex = nameRange.location + nameRange.length;
        NSString *nameString = [url substringFromIndex:fromIndex];
        
        returnString = nameString;
        NSRange firstRange = [nameString rangeOfString:@"&"];
        if (firstRange.length != 0) {
            NSInteger toIndex = firstRange.location;
            NSString *accessToken = [nameString substringToIndex:toIndex];
            returnString = accessToken;
        }
    }
        return returnString;
}
@end
