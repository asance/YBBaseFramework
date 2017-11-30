//
//  NSData+AES.h
//  Smile
//
//  Created by asance on 2017/5/6.
//  Copyright © 2017年 asance. All rights reserved.
//


#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encryption)

- (NSData *)AES128EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key;   //解密

- (NSData *)AES128CBCEncryptWithKey:(NSString *)key iv:(NSString *)iv;   //加密
- (NSData *)AES128CBCDecryptWithKey:(NSString *)key iv:(NSString *)iv;   //解密

@end
