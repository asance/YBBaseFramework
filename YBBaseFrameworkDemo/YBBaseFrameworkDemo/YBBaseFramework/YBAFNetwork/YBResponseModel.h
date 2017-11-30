//
//  YBResponseModel.h
//  YBNetAgent
//
//  Created by asance on 2017/5/8.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YBErrorModel;

@interface YBResponseModel : NSObject
/**业务结果码*/
@property(strong, nonatomic) NSNumber *code;
/*业务内容*/
@property(strong, nonatomic) NSObject *info;
/**业务信息*/
@property(copy, nonatomic) NSString *msg;

- (YBErrorModel *)loginStateErrorObj;
- (YBErrorModel *)errorObj;

- (BOOL)success;
- (NSString *)localErrorMessage;

+ (id)initWithResponseObject:(NSDictionary *)resultObject;

@end
