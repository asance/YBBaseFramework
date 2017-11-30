//
//  NSErrorCodeHandle.h
//  test_CodeReview
//
//  Created by asance on 2017/8/31.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSErrorCodeHandle : NSObject

/**单例对象*/
+ (instancetype)shareInstance;

/**是否匹配服务器层的错误码*/
- (BOOL)canCatchServerErrorCode:(NSString *)code;
/**是否匹配网络层的错误码*/
- (BOOL)canCatchNetworkErrorCode:(NSString *)code;
/**是否匹配默认的错误码*/
- (BOOL)canCatchDefaultErrorCode:(NSString *)code;

- (NSString *)explainForDefaultErrorCode:(NSString *)code;

@end
