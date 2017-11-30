//
//  YBHttpResponseModel.m
//  YBNetAgent
//
//  Created by asance on 2017/5/8.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBHttpResponseModel.h"
#import "YBResponseResultCode.h"

@implementation YBHttpResponseModel

+ (YBHttpResponseModel *)yb_objectWithKeyValues:(NSDictionary *)object{
    YBHttpResponseModel *model = [[YBHttpResponseModel alloc] init];
    if(nil==object){
        return model;
    }
    model.ret = object[@"ret"];
    model.content = object[@"content"];
    model.message = object[@"message"];
    model.milliUse = object[@"milliUse"];
    return model;
}
- (BOOL)success{
    if(HTTP_RESPONSE_SUCCESS==[self.ret integerValue]){
        return YES;
    }
    return NO;
}

- (NSString *)localErrorMessage{
    NSString *err = [NSString stringWithFormat:@"%@-%@",self.ret,self.message];
    return err;
}

@end
