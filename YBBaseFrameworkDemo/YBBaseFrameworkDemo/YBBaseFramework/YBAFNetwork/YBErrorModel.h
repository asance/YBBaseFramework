//
//  YBErrorModel.h
//  YoubanLoan
//
//  Created by asance on 2017/7/1.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBErrorModel : NSObject

/**错误码*/
@property(strong, nonatomic) NSNumber *code;
/**错误描述*/
@property(copy, nonatomic) NSString *msg;
/**用户信息*/
@property(strong, nonatomic) NSObject *userInfo;

+ (id)nullErrorObj;
+ (id)ErrorObjForURLError;
+ (id)ErrorObjForParamsError;
+ (id)ErrorObjForNULLError;
+ (id)ErrorObjForNOMoreError;
+ (id)ErrorObjForNOResponseError;
+ (id)ErrorObjForNSError:(NSError *)error;
@end
