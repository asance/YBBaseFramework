//
//  NSObject+UIErrorHandle.h
//  YoubanAgent
//
//  Created by asance on 2017/8/30.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBResponseErrorProtocol.h"
/**
 *if 1, program will ignore custom dealing method.
 *you can set 0, then can custom youself dealing method.
 */
#define kOpenAutoPerformErrorCallback   (0)

@interface NSObject (UIErrorHandle)<YBResponseErrorProtocol>
/**
 * 默认加载页面数据接口。
 * 每个NSObject对象默认带有该方法，
 * 复写逻辑与系统复写一致。
 */
- (void)loadInitializationData;

@end
