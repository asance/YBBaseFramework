//
//  YBBasePresenter.m
//  YoubanLoan
//
//  Created by asance on 2017/7/20.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBBasePresenter.h"
#import "YBErrorModel.h"
#import "NSObject+Dispatch.h"
#import "NSObject+ErrorCodeHandle.h"
#import "YBResponseErrorProtocol.h"

@implementation YBBasePresenter

- (BOOL)handlingError:(YBErrorModel *)error
               output:(NSObject *)output
          callbackSEL:(SEL)cSelector
               APISEL:(SEL)aSelector
         APISELParams:(NSDictionary *)aParams{
    
    if(!output) return YES;
    
    if(![output respondsToSelector:cSelector]) return YES;
    
    if(!error) return NO;
    
    //接口方法名称
    NSString *apiSelector = NSStringFromSelector(aSelector);
    //优先级1：是否忽略所有捕获处理的错误码
    BOOL canIgnoreAllErrorCode = [output canIgnoreAllErrorCodeForSEL:apiSelector];
    if(canIgnoreAllErrorCode){
        NSArray *argArray = @[error,apiSelector];;
        if(aParams){
            argArray = @[error,apiSelector,aParams];
        }
        [output performNullReturnSelector:@selector(didFetchAPIErrorForIgnoreAllHandlePriority:requestSEL:params:) withArguments:argArray];
        
        return YES;
    }
    //优先级2：是否捕获处理服务器错误的错误码
    BOOL catchServerErrorCode = [output canCatchServerErrorCode:[NSString stringWithFormat:@"%@",error.code] forSEL:apiSelector];
    if(catchServerErrorCode){
        NSArray *argArray = @[error,apiSelector];;
        if(aParams){
            argArray = @[error,apiSelector,aParams];
        }
        [output performNullReturnSelector:@selector(didFetchAPIErrorForServerExceptionHandlePriority:requestSEL:params:) withArguments:argArray];
        
        return YES;
    }
    //优先级3：是否捕获处理网络错误的错误码
    BOOL catchNetworkErrorCode = [output canCatchNetworkErrorCode:[NSString stringWithFormat:@"%@",error.code] forSEL:apiSelector];
    if(catchNetworkErrorCode){
        NSArray *argArray = @[error,apiSelector];;
        if(aParams){
            argArray = @[error,apiSelector,aParams];
        }
        [output performNullReturnSelector:@selector(didFetchAPIErrorForNetworkExceptionHandlePriority:requestSEL:params:) withArguments:argArray];
        
        return YES;
    }
    //优先级4：是否捕获默认处理的错误码
    BOOL catchDefaultErrorCode = [output canCatchDefaultErrorCode:[NSString stringWithFormat:@"%@",error.code] forSEL:apiSelector];
    if(catchDefaultErrorCode){
        //当前项目不作默认错误处理回调,仅当作toast提示
        NSString *msg = [output explainForDefaultErrorCode:[NSString stringWithFormat:@"%@",error.code]];
        if(msg.length){
            error.msg = msg;
        }
        NSArray *argArray = @[error,apiSelector];;
        if(aParams){
            argArray = @[error,apiSelector,aParams];
        }
        [output performNullReturnSelector:@selector(didFetchAPIErrorForDefaultHandlePriority:requestSEL:params:) withArguments:argArray];
        
        return YES;
    }
    //优先级5：是否捕获手动处理的错误码
    BOOL catchManulErrorCode = [output canCatchManulErrorCode:[NSString stringWithFormat:@"%@",error.code] forSEL:apiSelector];
    if(catchManulErrorCode){
        NSArray *argArray = @[error,apiSelector];;
        if(aParams){
            argArray = @[error,apiSelector,aParams];
        }
        [output performNullReturnSelector:@selector(didFetchAPIErrorForManualHandlePriority:requestSEL:params:) withArguments:argArray];
        
        return YES;
    }
    //优先级6：会处理捕获的全部错误码
    NSArray *argArray = @[error,apiSelector];;
    if(aParams){
        argArray = @[error,apiSelector,aParams];
    }
    [output performNullReturnSelector:@selector(didFetchAPIErrorForAllHandlePriority:requestSEL:params:) withArguments:argArray];
    
    return YES;
}

@end
