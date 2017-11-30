//
//  YBFwConfigDemo.h
//  test_CodeReview
//
//  Created by asance on 2017/10/23.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBResponseErrorProtocol.h"

#pragma mark - ViewControllerToInteractorPopline
/**数据流从控制器流向转换器*/
@protocol YBFwConfigDemoViewControllerToInteractorPopline <NSObject>
@optional
/**
 * 获取注册信息。
 * @param params 接口参数字典
 * 对应返回接口：-didFetchRegisterInfo:。
 */
- (void)fetchRegisterInfoWithParams:(NSDictionary *)params;

@end

#pragma mark - InteractorToPresenterPipline
/**数据流从转换器流向展示器*/
@protocol YBFwConfigDemoInteractorToPresenterPipline <NSObject>
@optional
/**
 * 处理interactor返回的注册信息数据，
 * 包含源参数，用YB_KEY_PARAMS来获取。
 * 可能包含错误参数，用YB_KEY_ERROR来获取。
 * 对应调用接口：-fetchRegisterInfoWithParams:。
 *
 * @param object 数据字典
 */
- (void)presentRegisterInfo:(NSDictionary *)object;

@end

#pragma mark - PresenterToViewControllerPipline
/**数据流从展示器流向控制器*/
@protocol YBFwConfigDemoPresenterToViewControllerPipline  <YBResponseErrorProtocol>
@optional
/**
 * 获取用户注册信息，控制器中需要的值都封装在回调字典里。
 * 对应请求接口：-fetchRegisterInfoWithParams:
 *
 * @param info 数据字典
 */
- (void)didFetchRegisterInfo:(NSDictionary *)info;

@end
