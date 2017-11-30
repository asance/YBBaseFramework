//
//  SecurityUtil.h
//  Smile
//
//  Created by asance on 14-11-24.
//  Copyright (c) 2014年 yaya. All rights reserved.
//

#import "SecurityUtil.h"
#import "NSData+AES.h"

@implementation SecurityUtil

#pragma mark - AES加密
//将string转成带密码的data
+(NSString*)encryptAESData:(NSString*)string app_key:(NSString*)key{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES128EncryptWithKey:key];
    
    return [encryptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

#pragma mark - AES解密
//将带密码的data转成string
+(NSString*)decryptAESData:(NSData*)data  app_key:(NSString*)key{
    //使用密码对data进行解密
    NSData *decryData = [data AES128DecryptWithKey:key];
    
    //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return str;
}


#pragma mark - AES128CBC加密
+ (NSString *)encryptAES128CBCData:(NSString *)string key:(NSString *)key iv:(NSString *)iv{
    //将nsstring转化为nsdata
    NSData *utf8Data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [utf8Data AES128CBCEncryptWithKey:key iv:iv];
    
    NSString *dataString = [encryptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    return dataString;
}
#pragma mark - AES128CBC解密
+ (NSDictionary *)decryptAES128CBCData:(NSData *)data key:(NSString *)key iv:(NSString *)iv{
    
    NSData *dictDeData = [[NSData alloc] initWithBase64EncodedData:data
                                                           options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    //使用密码对data进行解密
    NSData *decryData = [dictDeData AES128CBCDecryptWithKey:key iv:iv];
    
    NSDictionary *object = nil;
    object = [NSJSONSerialization JSONObjectWithData:decryData options:NSJSONReadingMutableContainers error:nil];
    
    return object;
}

@end
