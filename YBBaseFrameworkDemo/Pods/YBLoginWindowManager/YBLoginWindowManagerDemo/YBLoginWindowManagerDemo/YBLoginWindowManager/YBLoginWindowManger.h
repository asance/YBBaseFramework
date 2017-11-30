//
//  YBLoginWindowManger.h
//  YoubanAgent
//
//  Created by asance on 2017/8/28.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define kLoginWindowTag  (9092)

@interface YBLoginWindowManger : NSObject

/**登录窗口相关联的根控制器，当登录窗口消失后，可以对根控制器设置一些手动的回调*/
@property(strong, nonatomic) UIViewController *rootViewController;

/**登录窗口打开时回调*/
@property(copy, nonatomic) void(^onDisplayBlock)(void);
/**登录窗口消失时回调*/
@property(copy, nonatomic) void(^onDismissBlock)(void);

/**单例对象*/
+ (instancetype)shareInstance;

/**
 * 生成登录窗口对象
 * @param dismiss 登录窗口消失时回调
 */
- (void)showWindowWithDismiss:(void(^)(void))dismiss;
/**
 * 生成登录窗口对象
 * @param complete 登录窗口打开时回调
 * @param dismiss 登录窗口消失时回调
 */
- (void)showWindowWithComplete:(void(^)(void))complete dismiss:(void(^)(void))dismiss;

@end
