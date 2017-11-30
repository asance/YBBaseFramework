//
//  AESEncrypt.h
//  YBNetAgent
//
//  Created by asance on 2017/5/6.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESEncrypt : NSObject

/**
 * 获取AES128CBC加密字符串。
 * @param oriData 待加密utf8编码data
 * @param key key
 * @param iv iv
 * @return string 加密字符串
 */
+ (NSString *)stringAES128CBCEncryptForUTF8Data:(NSData*)oriData key:(NSString*)key iv:(NSString *)iv;
/**
 * 获取AES128CBC加密字符串。
 * @param oriString 待加密字符串
 * @param key key
 * @param iv iv
 * @return string 加密字符串
 */
+ (NSString *)stringAES128CBCEncryptForString:(NSString*)oriString key:(NSString*)key iv:(NSString *)iv;


/**
 * 获取AES128CBC加密data。
 * @param oriString 待加密字符串
 * @param key key
 * @param iv iv
 * @return data 加密data
 */
+ (NSData *)dataAES128CBCEncryptForString:(NSString *)oriString key:(NSString *)key iv:(NSString *)iv;
/**
 * 获取AES128CBC加密data。
 * @param oriData 待加密utf8编码data
 * @param key key
 * @param iv iv
 * @return data 加密data
 */
+ (NSData *)dataAES128CBCEncryptForUTF8Data:(NSData *)oriData key:(NSString *)key iv:(NSString *)iv;


#pragma mark - 重构解密
/**
 * 获取AES128CBC解密字符串。
 * @param oriString 待解密字符串
 * @param key key
 * @param iv iv
 * @return string 解密字符串
 */
+ (NSString *)stringAES128CBCDecryptForString:(NSString *)oriString key:(NSString *)key iv:(NSString *)iv;
/**
 * 获取AES128CBC解密字符串。
 * @param oriData 待解密utf8编码data
 * @param key key
 * @param iv iv
 * @return string 解密字符串
 */
+ (NSString *)stringAES128CBCDecryptForUTF8Data:(NSData *)oriData key:(NSString *)key iv:(NSString *)iv;

/**
 * 获取AES128CBC解密data。
 * @param oriString 待解密字符串
 * @param key key
 * @param iv iv
 * @return data 解密data
 */
+ (NSData *)dataAES128CBCDecryptForString:(NSString *)oriString key:(NSString *)key iv:(NSString *)iv;
/**
 * 获取AES128CBC解密data。
 * @param oriData 待解密utf8编码data
 * @param key key
 * @param iv iv
 * @return data 解密data
 */
+ (NSData *)dataAES128CBCDecryptForUTF8Data:(NSData *)oriData key:(NSString *)key iv:(NSString *)iv;

/**
 * 获取AES128CBC解密dictionary。
 * @param oriString 待解密字符串
 * @param key key
 * @param iv iv
 * @return dictionary 解密dictionary
 */
+ (NSDictionary *)dictionaryAES128CBCDecryptForString:(NSString *)oriString key:(NSString *)key iv:(NSString *)iv;
/**
 * 获取AES128CBC解密dictionary。
 * @param oriData 待解密utf8编码data
 * @param key key
 * @param iv iv
 * @return dictionary 解密dictionary
 */
+ (NSDictionary *)dictionaryAES128CBCDecryptForUTF8Data:(NSData *)oriData key:(NSString *)key iv:(NSString *)iv;


@end
