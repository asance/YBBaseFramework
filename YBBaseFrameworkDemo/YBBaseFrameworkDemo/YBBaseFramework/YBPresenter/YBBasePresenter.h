//
//  YBBasePresenter.h
//  YoubanLoan
//
//  Created by asance on 2017/7/20.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YBErrorModel;

/**错误信息处理类型枚举*/
typedef NS_ENUM(NSInteger, YBErrorHandlerType) {
    /**默认，自动处理*/
    YBErrorHandlerTypeDefault = 0,
    /**手动处理*/
    YBErrorHandlerTypeManual = 1,
    /**自动处理*/
    YBErrorHandlerTypeAuto = 2,
};


@interface YBBasePresenter : NSObject

/**
 * Automatic error mapping.
 * @param error error object,may be nil.
 * @param output callback recipient.
 * @param cSelector callback selector.
 * @param aSelector api selector.
 * @param aParams api params.
 */
- (BOOL)handlingError:(YBErrorModel *)error
               output:(NSObject *)output
          callbackSEL:(SEL)cSelector
               APISEL:(SEL)aSelector
         APISELParams:(NSDictionary *)aParams;

@end
