//
//  YBResponseErrorProtocol.h
//  YoubanAgent
//
//  Created by asance on 2017/8/29.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YBErrorModel;

@protocol YBResponseErrorProtocol <NSObject>
@optional
/**
 * 检测服务器出错回调。
 * 建议捕捉该回调，根据业务，处理对应的后续业务逻辑。
 * 例如：显现服务器错误窗口。
 * @param aSel 源请求接口
 * @param params 请求参数
 */
- (void)didFetchAPIErrorForServerExceptionHandlePriority:(YBErrorModel *)error requestSEL:(NSString *)aSel params:(NSDictionary *)params;

/**
 * 检测网络连接出错回调。
 * 建议捕捉该回调，根据业务，处理对应的后续业务逻辑。
 * 例如：显现网络错误窗口。
 * @param aSel 源请求接口
 * @param params 请求参数
 */
- (void)didFetchAPIErrorForNetworkExceptionHandlePriority:(YBErrorModel *)error requestSEL:(NSString *)aSel params:(NSDictionary *)params;

/**
 * 捕获所有的接口错误回调。
 * 建议捕捉该回调，根据业务，处理对应的后续业务逻辑。
 * 例如：显现错误toast。
 * @param aSel 源请求接口
 * @param params 请求参数
 */
- (void)didFetchAPIErrorForAllHandlePriority:(YBErrorModel *)error requestSEL:(NSString *)aSel params:(NSDictionary *)params;

/**
 * 捕获手动处理的接口错误回调。
 * 建议捕捉该回调，根据业务，处理对应的后续业务逻辑。
 * 例如：显现错误toast。
 * @param aSel 源请求接口
 * @param params 请求参数
 */
- (void)didFetchAPIErrorForManualHandlePriority:(YBErrorModel *)error requestSEL:(NSString *)aSel params:(NSDictionary *)params;

/**
 * 捕获默认处理的接口错误回调。
 * 建议捕捉该回调，根据业务，处理对应的后续业务逻辑。
 * 例如：显现错误toast。
 * @param aSel 源请求接口
 * @param params 请求参数
 */
- (void)didFetchAPIErrorForDefaultHandlePriority:(YBErrorModel *)error requestSEL:(NSString *)aSel params:(NSDictionary *)params;

/**
 * 忽略捕获所有的接口错误回调。
 * 建议捕捉该回调，根据业务，处理对应的后续业务逻辑。
 * 例如：显现错误toast。
 * @param aSel 源请求接口
 * @param params 请求参数
 */
- (void)didFetchAPIErrorForIgnoreAllHandlePriority:(YBErrorModel *)error requestSEL:(NSString *)aSel params:(NSDictionary *)params;

@end
