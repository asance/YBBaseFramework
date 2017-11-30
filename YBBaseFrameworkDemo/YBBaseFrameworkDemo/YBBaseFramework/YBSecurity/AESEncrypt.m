//
//  AESEncrypt.m
//  YBNetAgent
//
//  Created by asance on 2017/5/6.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "AESEncrypt.h"
#import "NSData+AES.h"
#import "YBLogDefine.h"

@implementation AESEncrypt

#pragma mark - 重构加密
+ (NSString *)stringAES128CBCEncryptForString:(NSString *)oriString key:(NSString *)key iv:(NSString *)iv{
    NSString *encryptString = nil;
    if(oriString.length&&key.length&&iv.length){
        NSData *oriData = [oriString dataUsingEncoding:NSUTF8StringEncoding];
        return [AESEncrypt stringAES128CBCEncryptForUTF8Data:oriData key:key iv:iv];
    }
    return encryptString;
}
+ (NSString *)stringAES128CBCEncryptForUTF8Data:(NSData *)oriData key:(NSString *)key iv:(NSString *)iv{
    NSString *encryptString = nil;
    //start-encrypt data-base64 string-return
    if(oriData&&key.length&&iv.length){
        NSData *encryptedData = [oriData AES128CBCEncryptWithKey:key iv:iv];
        encryptString = [encryptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    return encryptString;
}

+ (NSData *)dataAES128CBCEncryptForString:(NSString *)oriString key:(NSString *)key iv:(NSString *)iv{
    NSData *encryptData = nil;
    if(oriString.length&&key.length&&iv.length){
        NSData *oriData = [oriString dataUsingEncoding:NSUTF8StringEncoding];
        return [AESEncrypt dataAES128CBCEncryptForUTF8Data:oriData key:key iv:iv];
    }
    return encryptData;
}
+ (NSData *)dataAES128CBCEncryptForUTF8Data:(NSData *)oriData key:(NSString *)key iv:(NSString *)iv{
    NSData *encryptData = nil;
    //start-encrypt data-base64 string-utf8 data-return
    if(oriData&&key.length&&iv.length){
        NSData *encryptedData = [oriData AES128CBCEncryptWithKey:key iv:iv];
        NSString *encryptString = [encryptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        encryptData = [encryptString dataUsingEncoding:NSUTF8StringEncoding];
        YBLog(@"%@",encryptString);
    }
    return encryptData;
}


#pragma mark - 重构解密
+ (NSString *)stringAES128CBCDecryptForString:(NSString *)oriString key:(NSString *)key iv:(NSString *)iv{
    NSString *decryptString = nil;
    if(oriString.length&&key.length&&iv.length){
        NSData *oriData = [oriString dataUsingEncoding:NSUTF8StringEncoding];
        return [AESEncrypt stringAES128CBCDecryptForUTF8Data:oriData key:key iv:iv];
    }
    return decryptString;
}

+ (NSString *)stringAES128CBCDecryptForUTF8Data:(NSData *)oriData key:(NSString *)key iv:(NSString *)iv{
    NSString *decryptString = nil;
    //start-base64 data-decrypt data-utf8 string-return
    if(oriData&&key.length&&iv.length){
        NSData *decryData = [AESEncrypt dataAES128CBCDecryptForUTF8Data:oriData key:key iv:iv];
        if(decryData){
            decryptString = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
        }
    }
    return decryptString;
}

+ (NSData *)dataAES128CBCDecryptForString:(NSString *)oriString key:(NSString *)key iv:(NSString *)iv{
    NSData *decryptData = nil;
    if(oriString.length&&key.length&&iv.length){
        NSData *oriData = [oriString dataUsingEncoding:NSUTF8StringEncoding];
        decryptData = [AESEncrypt dataAES128CBCDecryptForUTF8Data:oriData key:key iv:iv];
    }
    return decryptData;
}
+ (NSData *)dataAES128CBCDecryptForUTF8Data:(NSData *)oriData key:(NSString *)key iv:(NSString *)iv{
    NSData *decryptData = nil;
    //start-base64 data-decrypt data-return
    if(oriData&&key.length&&iv.length){
        NSData *base64DeData = [[NSData alloc] initWithBase64EncodedData:oriData
                                                                 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        decryptData = [base64DeData AES128CBCDecryptWithKey:key iv:iv];
    }
    return decryptData;
}

+ (NSDictionary *)dictionaryAES128CBCDecryptForString:(NSString *)oriString key:(NSString *)key iv:(NSString *)iv{
    NSDictionary *dict = nil;
    if(oriString.length&&key.length&&iv.length){
        NSData *oriData = [oriString dataUsingEncoding:NSUTF8StringEncoding];
        return [AESEncrypt dictionaryAES128CBCDecryptForUTF8Data:oriData key:key iv:iv];
    }
    return dict;
}

+ (NSDictionary *)dictionaryAES128CBCDecryptForUTF8Data:(NSData *)oriData key:(NSString *)key iv:(NSString *)iv{
    NSDictionary *dict = nil;
    NSError *error = nil;

    if(oriData&&key.length&&iv.length){
        NSData *decryptData = [AESEncrypt dataAES128CBCDecryptForUTF8Data:oriData key:key iv:iv];
        if(decryptData){
            dict = [NSJSONSerialization JSONObjectWithData:decryptData options:NSJSONReadingMutableContainers error:&error];
            if(error){
                YBLog(@"%@",error.localizedDescription);
                return nil;
            }
        }
    }
    return dict;
}
@end
