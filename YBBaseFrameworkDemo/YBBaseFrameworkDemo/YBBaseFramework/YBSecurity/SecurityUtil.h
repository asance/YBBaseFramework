//
//  SecurityUtil.h
//  Smile
//
//  Created by asance on 14-11-24.
//  Copyright (c) 2014年 yaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityUtil : NSObject 

#pragma mark - AES加密
//将string转成带密码的data
+ (NSString*)encryptAESData:(NSString*)string app_key:(NSString*)key ;
//将带密码的data转成string
+(NSString*)decryptAESData:(NSData*)data app_key:(NSString*)key ;

//将string转成带密码的data
+ (NSString*)encryptAES128CBCData:(NSString*)string key:(NSString*)key iv:(NSString *)iv;
//将带密码的data转成string
+(NSDictionary *)decryptAES128CBCData:(NSData*)data key:(NSString*)key iv:(NSString *)iv;

@end
