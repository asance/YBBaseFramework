//
//  YBRequestWorkerProtocol.h
//  YoubanLoan
//
//  Created by asance on 2017/7/20.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YBErrorModel;

@protocol YBRequestWorkerProtocol <NSObject>
@optional
/**
 * 以GET方式获取资源请求信息
 * 该接口不带参数
 * @param url url
 * @param success 成功返回信息
 * @param failure 错误返回信息
 */
- (void)fetchDataInfoByGETMethodWithURL:(NSString *)url success:(void(^)(NSDictionary *resultObject))success failure:(void(^)(YBErrorModel *error))failure;

/**
 * 以GET方式获取资源请求信息
 * 该接口会带参数
 * @param url url
 * @param params 请求参数
 * @param success 成功返回信息
 * @param failure 错误返回信息
 */
- (void)fetchDataInfoByGETMethodWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(NSDictionary *resultObject))success failure:(void(^)(YBErrorModel *error))failure;

/**
 * 以GET方式获取资源请求信息
 * 该接口会带参数
 * @param url url
 * @param params 请求参数
 * @param success 成功返回信息
 * @param failure 错误返回信息
 */
- (void)fetchDataInfoByPartyGETMethodWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(NSDictionary *resultObject))success failure:(void(^)(YBErrorModel *error))failure;

/**
 * 以POST方式获取资源请求信息
 * 该接口不带参数
 * @param url url
 * @param success 成功返回信息
 * @param failure 错误返回信息
 */
- (void)fetchDataInfoByPOSTMethodWithURL:(NSString *)url success:(void(^)(NSDictionary *resultObject))success failure:(void(^)(YBErrorModel *error))failure;

/**
 * 以POST方式获取资源请求信息
 * 该接口会带参数
 * @param url url
 * @param params 请求参数
 * @param success 成功返回信息
 * @param failure 错误返回信息
 */
- (void)fetchDataInfoByPOSTMethodWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(NSDictionary *resultObject))success failure:(void(^)(YBErrorModel *error))failure;

/**
 * 以POST方式上传资源请求信息
 * 该接口会带参数
 * @param url url
 * @param params 请求参数
 * @param images 请求参数
 * @param success 成功返回信息
 * @param failure 错误返回信息
 */
- (void)uploadImageInfoByPOSTMethodWithURL:(NSString *)url params:(NSDictionary *)params images:(NSArray *)images success:(void(^)(NSDictionary *resultObject))success failure:(void(^)(YBErrorModel *error))failure;

@end
