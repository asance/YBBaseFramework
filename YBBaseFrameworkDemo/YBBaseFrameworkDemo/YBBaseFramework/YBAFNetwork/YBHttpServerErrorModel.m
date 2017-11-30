//
//  YBHttpServerErrorModel.m
//  YoubanAgent
//
//  Created by asance on 2017/5/28.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBHttpServerErrorModel.h"
#import "YBResponseResultCode.h"

@implementation YBHttpServerErrorModel

+ (id)initWithResponseObj:(NSDictionary *)obj{
    
    YBHttpServerErrorModel *error = [[YBHttpServerErrorModel alloc] init];
    
    if(!obj){
        error.serverError = YES;
        error.code = @(HTTP_RESPONSE_ERROR_NODATA);
        error.message = [NSString stringWithFormat:@"%@",@"请求无数据"];
        
        return error;
    }
    
    NSArray *keyArray = [obj allKeys];
    if(![keyArray containsObject:@"content"]){
        error.serverError = YES;
        error.code = obj[@"code"];//@(HTTP_RESPONSE_ERROR_NODATA);
        error.message = [NSString stringWithFormat:@"%@",[obj objectForKey:@"message"]];

        return error;
    }
    
    error.serverError = NO;
    return error;
}

@end
