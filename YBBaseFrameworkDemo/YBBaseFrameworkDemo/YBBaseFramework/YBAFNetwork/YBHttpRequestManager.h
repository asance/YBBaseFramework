//
//  YBHttpRequestManager.h
//  YBNet
//
//  Created by asance on 2017/4/27.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#define HTTP_REQUEST_ENCRYPT_OPEN 1
#define HTTP_REQUEST_ENCRYPT_KEY @"abcdef0123456789"
#define HTTP_REQUEST_ENCRYPT_IV @"0123456789abcdef"

#define HTTPManagerFetchedMainThread(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

typedef void(^HttpRequestSuccess)(NSObject *resultObject);
typedef void(^HttpRequestFailure)(NSError *error);
typedef void(^HttpUploadProgress)(NSProgress *uploadProgress);

@interface YBHttpRequestManager : NSObject
/**default yes, if set no,will not print log*/
@property(assign, nonatomic) BOOL logSwitch;
/**UUID of current device*/
@property(copy, nonatomic) NSString *UUID;
/**authorization of current request*/
@property(copy, nonatomic) NSString *authorization;

+ (instancetype)shareInstance;

#pragma mark - GET
/**
 * Get请求.
 * @param url 接口url字符串
 * @param param 请求参数
 * @param success 请求成功回调
 * @param failure 请求失败回调
 */
- (void)Get:(NSString *)url params:(NSDictionary *)param success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
/**
 * Get请求.
 * @param url 接口url字符串
 * @param param 请求参数
 * @param success 请求成功回调
 * @param failure 请求失败回调
 */
- (void)PartyGet:(NSString *)url params:(NSDictionary *)param success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

#pragma mark - Post
/**
 * Post请求.
 * @param url 接口url字符串
 * @param param 请求参数
 * @param success 请求成功回调
 * @param failure 请求失败回调
 */
- (void)Post:(NSString *)url params:(NSDictionary *)param success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

#pragma mark - Upload
/**
 * 上传图片请求.
 * 仅支持NSDictionary集合,仅支持NSData/UIImage类型.
 *
 * 组合格式：{@“name”:@"xxx",@"image":id<NSData/UIImage>}
 *
 * @param url 接口url字符串
 * @param param 请求参数
 * @param images image集合
 * @param progress 上传进度
 * @param success 请求成功回调
 * @param failure 请求失败回调
 */
- (void)Upload:(NSString *)url params:(NSDictionary *)param images:(NSArray *)images progress:(HttpUploadProgress)progress success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;



@end
