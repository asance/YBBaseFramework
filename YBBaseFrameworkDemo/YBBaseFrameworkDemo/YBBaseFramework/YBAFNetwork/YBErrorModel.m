//
//  YBErrorModel.m
//  YoubanLoan
//
//  Created by asance on 2017/7/1.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBErrorModel.h"
#import "YBResponseResultCode.h"

@implementation YBErrorModel

+ (id)nullErrorObj{
    YBErrorModel *err = [[YBErrorModel alloc] init];
    err.code = @(YB_RESPONSE_ERROR_NULL);
    err.msg = @"请求返回内容为空";
    return err;
}
+ (id)ErrorObjForNULLError{
    YBErrorModel *err = [[YBErrorModel alloc] init];
    err.code = @(YB_RESPONSE_ERROR_NULL);
    err.msg = @"请求返回内容为空";
    return err;
}
+ (id)ErrorObjForNOMoreError{
    YBErrorModel *err = [[YBErrorModel alloc] init];
    err.code = @(YB_RESPONSE_ERROR_NO_MORE_DATA);
    err.msg = @"没有更多数据了";
    return err;
}
+ (id)ErrorObjForURLError{
    YBErrorModel *err = [[YBErrorModel alloc] init];
    err.code = @(YB_RESPONSE_ERROR_ILLEGAL_URL);
    err.msg = @"请求URL错误";
    return err;
}
+ (id)ErrorObjForParamsError{
    YBErrorModel *err = [[YBErrorModel alloc] init];
    err.code = @(YB_RESPONSE_ERROR_ILLEGAL_PARAMS);
    err.msg = @"请求参数错误";
    return err;
}
+ (id)ErrorObjForNOResponseError{
    YBErrorModel *err = [[YBErrorModel alloc] init];
    err.code = @(YB_RESPONSE_ERROR_NO_RESPONSE);
    err.msg = YB_NO_RESPONSE_DATA;
    return err;
}

+ (id)ErrorObjForNSError:(NSError *)error{
    NSInteger code = error.code;
    NSString *newErrReason = [NSString stringWithFormat:@"%@%@",@(error.code),error.localizedDescription];
    if([newErrReason containsString:@"-1011"]){
        if([newErrReason containsString:@"(404)"]){
            code = 404;
        }
        else if ([newErrReason containsString:@"(401)"]){
            code = 401;
        }
    }
    YBErrorModel *yerror = [[YBErrorModel alloc] init];
    yerror.code = @(code);
    yerror.msg = newErrReason;
    return yerror;
}


@end
