//
//  YBHttpResponseModel.h
//  YBNetAgent
//
//  Created by asance on 2017/5/8.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBHttpResponseModel : NSObject
/**http返回码*/
@property(strong, nonatomic) NSNumber *ret;
/**http返回内容*/
@property(strong, nonatomic) NSDictionary *content;
/**http信息*/
@property(copy, nonatomic) NSString *message;
/**http耗时,可忽略*/
@property(strong, nonatomic) NSNumber *milliUse;

+ (YBHttpResponseModel *)yb_objectWithKeyValues:(NSDictionary *)object;
- (BOOL)success;
- (NSString *)localErrorMessage;

@end

