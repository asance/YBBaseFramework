//
//  NSObject+UIErrorHandle.m
//  YoubanAgent
//
//  Created by asance on 2017/8/30.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "NSObject+UIErrorHandle.h"
#import "UIViewController+Alert.h"
#import "YBLoginWindowManger.h"
#import "YBErrorPageView.h"
#import "YBErrorModel.h"
#import "SVProgressHUD.h"

@implementation NSObject (UIErrorHandle)

- (void)didFetchAPIErrorForServerExceptionHandlePriority:(YBErrorModel *)error requestSEL:(NSString *)aSel params:(NSDictionary *)params{
    [SVProgressHUD dismiss];
    __weak __typeof(&*self)weakSelf = self;
    
    [YBErrorPageView showServerErrorWithReloadHandler:^{
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if(!strongSelf) return;
        
        [strongSelf setErrorCallbackWithSEL:aSel params:params];
    }];
}

- (void)didFetchAPIErrorForNetworkExceptionHandlePriority:(YBErrorModel *)error requestSEL:(NSString *)aSel params:(NSDictionary *)params{
    [SVProgressHUD dismiss];
    __weak __typeof(&*self)weakSelf = self;
    
    [YBErrorPageView showNoNetErrorWithReloadHandler:^{
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if(!strongSelf) return;
        
        [strongSelf setErrorCallbackWithSEL:aSel params:params];
    }];
}

- (void)didFetchAPIErrorForDefaultHandlePriority:(YBErrorModel *)error requestSEL:(NSString *)aSel params:(NSDictionary *)params{
    [SVProgressHUD dismiss];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:error.msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //项目业务逻辑处理
#if kOpenAutoPerformErrorCallback
        __weak __typeof(&*self)weakSelf = self;
        [[YBLoginWindowManger shareInstance] showWindowWithComplete:^{
        } dismiss:^{
            __strong __typeof(&*weakSelf)strongSelf = weakSelf;
            if(!strongSelf) return;
            [strongSelf setErrorCallbackWithSEL:aSel params:params];
        }];
#else
        __weak __typeof(&*self)weakSelf = self;
        [[YBLoginWindowManger shareInstance] showWindowWithComplete:^{
            __strong __typeof(&*weakSelf)strongSelf = weakSelf;
            if(!strongSelf) return;
            
            BOOL isViewControllerClass = NO;
            UIViewController *custViewController = (UIViewController *)strongSelf;
            if([custViewController isKindOfClass:[UIViewController class]]){
                isViewControllerClass = YES;
                if (custViewController.presentingViewController) {
                    [custViewController dismissViewControllerAnimated:NO completion:nil];
                } else {
                    [custViewController.navigationController popToRootViewControllerAnimated:NO];
                }
            }
        } dismiss:^{
        }];
#endif
    }]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Private Method
- (void)setErrorCallbackWithSEL:(NSString *)aSel params:(NSDictionary *)params{
    if(aSel.length){
        SEL gSEL = NSSelectorFromString(aSel);
        BOOL isHadArgsMethod = ([aSel rangeOfString:@":"].location!=NSNotFound);
        //优先级1：如果obj能响应该方法，直接回调
        if([self respondsToSelector:gSEL]){
            IMP imp = [self methodForSelector:gSEL];
            if(isHadArgsMethod){
                void(*func)(id, SEL, id) = (void *)imp;
                func(self, gSEL, params);
            }
            else{
                void(*func)(id, SEL) = (void *)imp;
                func(self, gSEL);
            }
            return;
        }
        //优先级2：如果obj能响应loadInitializationData方法，直接回调
        SEL dSEL = @selector(loadInitializationData);
        if([self respondsToSelector:dSEL]){
            [self loadInitializationData];
            return;
        }
    }
}
- (void)setErrorCallbackWithDefaultSEL{
    //优先级2：如果obj能响应loadInitializationData方法，直接回调
    SEL dSEL = @selector(loadInitializationData);
    if([self respondsToSelector:dSEL]){
        [self loadInitializationData];
        return;
    }
}

#pragma mark - 默认初始化页面数据接口
- (void)loadInitializationData{
    
}

@end
