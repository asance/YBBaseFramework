//
//  YBResponseModel.m
//  YBNetAgent
//
//  Created by asance on 2017/5/8.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBResponseModel.h"
#import "YBErrorModel.h"
#import "YBHttpResponseModel.h"
#import "YBHttpServerErrorModel.h"
#import "YBResponseResultCode.h"

@implementation YBResponseModel

+ (YBResponseModel *)yb_objectWithKeyValues:(NSDictionary *)object{
    YBResponseModel *model = [[YBResponseModel alloc] init];
    if(nil==object){
        return model;
    }
    model.code = object[@"code"];
    model.info = object[@"info"];
    model.msg = object[@"msg"];
    return model;
}
- (BOOL)success{
    if(YB_RESPONSE_SUCCESS==[self.code integerValue]){
        return YES;
    }
    return NO;
}

- (NSString *)localErrorMessage{
    NSString *err = [NSString stringWithFormat:@"%@",self.msg];
    return err;
}

- (YBErrorModel *)loginStateErrorObj{
    NSString *err = [NSString stringWithFormat:@"%@%@",self.code,self.msg];
    YBErrorModel *error = [[YBErrorModel alloc] init];
    error.code = self.code;
    error.msg = err;
    return error;
}
- (YBErrorModel *)errorObj{
    if(NO==[self success]){
        YBErrorModel *error = [[YBErrorModel alloc] init];
        error.code = self.code;
        error.msg = self.msg;
        error.userInfo = self.info;
        return error;
    }
    return nil;
}

+ (id)initWithResponseObject:(NSDictionary *)resultObject{
    
    //判断服务器是否返回错误信息
    YBHttpServerErrorModel *sErrObj = [YBHttpServerErrorModel initWithResponseObj:(NSDictionary *)resultObject];
    if(sErrObj.serverError){
        
        YBResponseModel *ybObj = [[YBResponseModel alloc] init];
        ybObj.code = sErrObj.code;
        ybObj.msg = [sErrObj message];
        return ybObj;
    }
    
    sErrObj = nil;
    
    //判断网络是否返回错误信息
    YBHttpResponseModel *httpObj = [YBHttpResponseModel yb_objectWithKeyValues:resultObject];
    if([httpObj success]){
        YBResponseModel *ybObj = [YBResponseModel yb_objectWithKeyValues:httpObj.content];
        //判断业务逻辑是否返回错误信息
        if([ybObj.info isKindOfClass:[NSString class]]){
            ybObj.info = [[NSDictionary alloc] init];
        }
        return ybObj;
    }
    else{
        
        YBResponseModel *ybObj = [[YBResponseModel alloc] init];
        ybObj.code = httpObj.ret;
        ybObj.msg = [httpObj localErrorMessage];
        return ybObj;
    }
}

@end
