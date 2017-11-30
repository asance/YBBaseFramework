//
//  YBHttpServerErrorModel.h
//  YoubanAgent
//
//  Created by asance on 2017/5/28.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBHttpServerErrorModel : NSObject
/**结果码*/
@property(strong, nonatomic) NSNumber *code;

/**错误信息*/
@property(copy, nonatomic) NSString *message;

/**是否出现错误
 * 服务器是否出错，YES，出错，NO，正常
 * 如果出错，应该直接回抛错误信息，停止解析返回数据。
 */
@property(assign, nonatomic) BOOL serverError;

+ (id)initWithResponseObj:(NSDictionary *)obj;

@end

/**
 服务器错误返回：
 success:{
 code = 201;
 message = " com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException";
 }
 */
