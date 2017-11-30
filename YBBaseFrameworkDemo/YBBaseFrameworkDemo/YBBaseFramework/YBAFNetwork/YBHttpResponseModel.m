//
//  YBHttpResponseModel.m
//  YBNetAgent
//
//  Created by asance on 2017/5/8.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBHttpResponseModel.h"

@implementation YBHttpResponseModel

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
