//
//  YBBaseRequestWorker.m
//  YoubanAgent
//
//  Created by asance on 2017/8/29.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBBaseRequestWorker.h"
#import "YBHttpRequestManager.h"
#import "YBResponseModel.h"
#import "YBErrorModel.h"
#import "YBLogDefine.h"

@implementation YBBaseRequestWorker

- (void)fetchDataInfoByGETMethodWithURL:(NSString *)url success:(void (^)(NSDictionary *))success failure:(void (^)(YBErrorModel *))failure{
    
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[YBHttpRequestManager shareInstance] Get:urlString params:nil success:^(NSObject *resultObject) {
        YBLog(@"SUCCESS: %@",resultObject);
        
        //判断网络是否返回错误信息
        YBResponseModel *obj = [YBResponseModel initWithResponseObject:(NSDictionary *)resultObject];
        if([obj success]){
            if(success) success((NSDictionary *)obj.info);
        }
        else{
            if(failure) failure([obj errorObj]);
        }
        
    } failure:^(NSError *error) {
        YBErrorModel *yerror = [YBErrorModel ErrorObjForNSError:error];
        if(failure) failure(yerror);
    }];
}

- (void)fetchDataInfoByGETMethodWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(YBErrorModel *))failure{
    
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [[YBHttpRequestManager shareInstance] Get:urlString params:params success:^(NSObject *resultObject) {
        YBLog(@"SUCCESS: %@",resultObject);
        
        //判断网络是否返回错误信息
        YBResponseModel *obj = [YBResponseModel initWithResponseObject:(NSDictionary *)resultObject];
        if([obj success]){
            if(success) success((NSDictionary *)obj.info);
        }
        else{
            if(failure) failure([obj errorObj]);
        }
        
    } failure:^(NSError *error) {
        YBErrorModel *yerror = [YBErrorModel ErrorObjForNSError:error];
        if(failure) failure(yerror);
    }];
}
- (void)fetchDataInfoByPartyGETMethodWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(NSDictionary *resultObject))success failure:(void(^)(YBErrorModel *error))failure{
    
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[YBHttpRequestManager shareInstance] PartyGet:urlString params:params success:^(NSObject *resultObject) {
        YBLog(@"SUCCESS: %@",resultObject);
        
        //判断网络是否返回错误信息
        YBResponseModel *obj = [YBResponseModel initWithResponseObject:(NSDictionary *)resultObject];
        if([obj success]){
            if(success) success((NSDictionary *)obj.info);
        }
        else{
            if(failure) failure([obj errorObj]);
        }
        
    } failure:^(NSError *error) {
        YBErrorModel *yerror = [YBErrorModel ErrorObjForNSError:error];
        if(failure) failure(yerror);
    }];
}
- (void)fetchDataInfoByPOSTMethodWithURL:(NSString *)url success:(void(^)(NSDictionary *resultObject))success failure:(void(^)(YBErrorModel *error))failure{
    
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [[YBHttpRequestManager shareInstance] Post:urlString params:nil success:^(NSObject *resultObject) {
        YBLog(@"success: %@",resultObject);
        
        //判断网络是否返回错误信息
        YBResponseModel *obj = [YBResponseModel initWithResponseObject:(NSDictionary *)resultObject];
        if([obj success]){
            if(success) success((NSDictionary *)obj.info);
        }
        else{
            if(failure) failure([obj errorObj]);
        }
        
    } failure:^(NSError *error) {
        YBErrorModel *yerror = [YBErrorModel ErrorObjForNSError:error];
        if(failure) failure(yerror);
    }];
}

- (void)fetchDataInfoByPOSTMethodWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(NSDictionary *resultObject))success failure:(void(^)(YBErrorModel *error))failure{
    
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [[YBHttpRequestManager shareInstance] Post:urlString params:params success:^(NSObject *resultObject) {
        YBLog(@"SUCCESS: %@",resultObject);
        
        //判断网络是否返回错误信息
        YBResponseModel *obj = [YBResponseModel initWithResponseObject:(NSDictionary *)resultObject];
        if([obj success]){
            if(success) success((NSDictionary *)obj.info);
        }
        else{
            if(failure) failure([obj errorObj]);
        }
        
    } failure:^(NSError *error) {
        YBErrorModel *yerror = [YBErrorModel ErrorObjForNSError:error];
        if(failure) failure(yerror);
    }];
}

- (void)uploadImageInfoByPOSTMethodWithURL:(NSString *)url params:(NSDictionary *)params images:(NSArray *)images success:(void (^)(NSDictionary *))success failure:(void (^)(YBErrorModel *))failure{
    
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [[YBHttpRequestManager shareInstance] Upload:urlString params:params images:images progress:^(NSProgress *uploadProgress) {
        
    } success:^(NSObject *resultObject) {
        YBLog(@"success:%@",resultObject);
        
        //判断网络是否返回错误信息
        YBResponseModel *obj = [YBResponseModel initWithResponseObject:(NSDictionary *)resultObject];
        if([obj success]){
            if(success) success((NSDictionary *)obj.info);
        }
        else{
            if(failure) failure([obj errorObj]);
        }
        
    } failure:^(NSError *error) {
        YBErrorModel *yerror = [YBErrorModel ErrorObjForNSError:error];
        if(failure) failure(yerror);
    }];
}

@end
