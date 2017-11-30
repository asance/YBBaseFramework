//
//  NSObject+ErrorCodeHandle.h
//  YoubanAgent
//
//  Created by asance on 2017/8/29.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ErrorCodeHandle)

#pragma mark - 移除捕获与关联
/**
 * 移除指定接口的error码捕获
 * @param SELName 指定接口
 */
- (void)removeAPIHandleForSEL:(NSString *)SELName;
/**
 * 移除所有接口的error码捕获
 */
- (void)removeAllHandle;

/**
 * 移除指定接口的服务器错误码捕获
 * @param SELName 指定接口
 */
- (void)removeServerErrorHandleForSEL:(NSString *)SELName;
/**
 * 移除指定接口的网络错误码捕获
 * @param SELName 指定接口
 */
- (void)removeNetworkErrorHandleForSEL:(NSString *)SELName;
/**
 * 移除指定接口的默认错误码捕获
 * @param SELName 指定接口
 */
- (void)removeDefaultErrorHandleForSEL:(NSString *)SELName;
/**
 * 移除指定接口的指定错误码捕获
 * @param SELName 指定接口
 */
- (void)removeCustomErrorHandleForSEL:(NSString *)SELName;

#pragma mark - 设置捕获码与接口
/**
 * 设置不会处理所有的error码。
 * 主要针对不需要处理回调的接口。
 */
- (void)setNotHandleAllErrorCode;

/**
 * 设置处理服务器异常的error码。
 * 默认的error码暂时包括：1004。
 * 对应的码解释为：服务器异常.
 *
 * 主要针对需要处理回调的接口。
 */
- (void)setServerErrorCodeHandle;

/**
 * 设置处理网络异常的error码。
 * 默认的error码暂时包括：1009。
 * 对应的码解释为：服务器异常.
 *
 * 主要针对需要处理回调的接口。
 */
- (void)setNetworkErrorCodeHandle;

/**
 * 设置处理默认的error码。
 * 默认的error码暂时包括：400、401、440、201、210。
 * 对应的码解释为：该帐号已经在其它设备登录、
                该帐号已经在其它设备登录、
                该帐号已经被冻结、
                该帐号已经被冻结、
                该用户已经被冻结。
 *
 * 主要针对需要处理回调的接口。
 */
- (void)setDefaultErrorCodeHandle;
/**根据码获取缓存的码释义*/
- (NSString *)explainForDefaultErrorCode:(NSString *)code;

/**
 * 设置除了处理默认的error码外，再添加额外的处理错码。
 * 默认的error码暂时包括：400、401、440、201、210.
 * 对应的码解释为：该帐号已经在其它设备登录、
                该帐号已经在其它设备登录、
                该帐号已经被冻结、
                该帐号已经被冻结、
                该用户已经被冻结。
 *
 * 主要针对需要处理回调的接口。
 * 一旦调用设置手动处理的错误码，则设置忽略所有错误处理为nil。
 * @param codes 错误码集合，是一个SEL名称集合。
 * @param SELName 指定接口
 */
- (void)setExtraHandleErrorCodes:(NSArray *)codes forSEL:(NSString *)SELName;

/**
 * 获取接口的例外处理错误码
 */
- (NSMutableArray *)extraHandleErrorCodesForSEL:(NSString *)SELName;

/**
 * 设置只处理设定的错码。
 * 主要针对需要处理回调的接口。
 * 一旦调用设置手动处理的错误码，则设置忽略所有错误处理为nil。
 * @param codes 错误码集合，是一个SEL名称集合。
 * @param ignoreSNCode 是否忽略服务器层与网络层的错误码，如果no，服务器与网络层的错误处理优先级仍然比手动设置的codes高。
 * @param SELName 指定接口
 */
- (void)setOnlyHandleErrorCodes:(NSArray *)codes ignoreServerAndNetworkErrorCode:(BOOL)ignoreSNCode forSEL:(NSString *)SELName;


#pragma mark - 捕获优先级判断
/**
 * 是否可以不捕获任何错误码,优先级最高 0
 * @param SELName 指定接口
 */
- (BOOL)canIgnoreAllErrorCodeForSEL:(NSString *)SELName;

/**
 * 是否可以捕获服务器错误的错误码,优先级次之 1
 * @param SELName 指定接口
 */
- (BOOL)canCatchServerErrorCode:(NSString *)code forSEL:(NSString *)SELName;

/**
 * 是否可以捕获网络错误的错误码,优先级次之 2
 * @param SELName 指定接口
 */
- (BOOL)canCatchNetworkErrorCode:(NSString *)code forSEL:(NSString *)SELName;

/**
 * 是否可以捕获默认的错误码,优先级次之 3
 * @param SELName 指定接口
 */
- (BOOL)canCatchDefaultErrorCode:(NSString *)code forSEL:(NSString *)SELName;

/**
 * 是否可以捕获指定的错误码,优先级次之 4
 * @param SELName 指定接口
 */
- (BOOL)canCatchManulErrorCode:(NSString *)code forSEL:(NSString *)SELName;


@end
