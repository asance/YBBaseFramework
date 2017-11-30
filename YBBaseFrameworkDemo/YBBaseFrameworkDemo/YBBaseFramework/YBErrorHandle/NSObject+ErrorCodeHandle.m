//
//  NSObject+ErrorCodeHandle.m
//  YoubanAgent
//
//  Created by asance on 2017/8/29.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "NSObject+ErrorCodeHandle.h"
#import "NSErrorCodeHandle.h"
#import <objc/runtime.h>

static char NSObjectIgnoreAllErrorHandle        = '\1';
static char NSObjectIgnoreServerErrorHandle     = '\2';
static char NSObjectIgnoreNetworkErrorHandle    = '\3';
static char NSObjectIgnoreDefaultErrorHandle    = '\4';
static char NSObjectAPIExtraErrorCode           = '\5';

@implementation NSObject (ErrorCodeHandle)

#pragma mark - 移除捕获与关联
- (void)removeAPIHandleForSEL:(NSString *)SELName{
    @synchronized (self) {
        if(0==SELName.length) return;
        
        NSMutableDictionary *extraCodeDict = objc_getAssociatedObject(self, &NSObjectAPIExtraErrorCode);
        if(extraCodeDict){
            [extraCodeDict removeObjectForKey:SELName];
        }
        
        if(0==extraCodeDict.count){
            objc_setAssociatedObject(self, &NSObjectAPIExtraErrorCode, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}
- (void)removeAllHandle{
    @synchronized (self) {
        objc_setAssociatedObject(self, &NSObjectIgnoreAllErrorHandle, @"1", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &NSObjectIgnoreServerErrorHandle, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &NSObjectIgnoreNetworkErrorHandle, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &NSObjectIgnoreDefaultErrorHandle, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &NSObjectAPIExtraErrorCode, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (void)removeServerErrorHandleForSEL:(NSString *)SELName{
    @synchronized (self) {
        if(0==SELName.length) return;
        
        NSMutableArray *ErrorHandleArray = objc_getAssociatedObject(self, &NSObjectIgnoreServerErrorHandle);
        if(nil==ErrorHandleArray){
            ErrorHandleArray = [[NSMutableArray alloc] init];
            objc_setAssociatedObject(self, &NSObjectIgnoreServerErrorHandle, ErrorHandleArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        if(NO==[ErrorHandleArray containsObject:SELName]){
            [ErrorHandleArray addObject:SELName];
        }
    }
}
- (void)removeNetworkErrorHandleForSEL:(NSString *)SELName{
    @synchronized (self) {
        if(0==SELName.length) return;
        
        NSMutableArray *ErrorHandleArray = objc_getAssociatedObject(self, &NSObjectIgnoreNetworkErrorHandle);
        if(nil==ErrorHandleArray){
            ErrorHandleArray = [[NSMutableArray alloc] init];
            objc_setAssociatedObject(self, &NSObjectIgnoreNetworkErrorHandle, ErrorHandleArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        if(NO==[ErrorHandleArray containsObject:SELName]){
            [ErrorHandleArray addObject:SELName];
        }
    }
}
- (void)removeDefaultErrorHandleForSEL:(NSString *)SELName{
    @synchronized (self) {
        if(0==SELName.length) return;
        
        NSMutableArray *ErrorHandleArray = objc_getAssociatedObject(self, &NSObjectIgnoreDefaultErrorHandle);
        if(nil==ErrorHandleArray){
            ErrorHandleArray = [[NSMutableArray alloc] init];
            objc_setAssociatedObject(self, &NSObjectIgnoreDefaultErrorHandle, ErrorHandleArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        if(NO==[ErrorHandleArray containsObject:SELName]){
            [ErrorHandleArray addObject:SELName];
        }
    }
}
- (void)removeCustomErrorHandleForSEL:(NSString *)SELName{
    @synchronized (self) {
        if(0==SELName.length) return;
        
        NSMutableDictionary *ErrorHandleDict = objc_getAssociatedObject(self, &NSObjectAPIExtraErrorCode);
        if(nil==ErrorHandleDict){
            ErrorHandleDict = [[NSMutableDictionary alloc] init];
            objc_setAssociatedObject(self, &NSObjectAPIExtraErrorCode, ErrorHandleDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        else{
            [ErrorHandleDict removeObjectForKey:SELName];
        }
    }
}

#pragma mark - 设置捕获码与接口
- (void)setNotHandleAllErrorCode{
    [self removeAllHandle];
}
- (void)setIgnoreErrorHandleForType:(char)type{
    objc_setAssociatedObject(self, &type, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableArray *ErrorHandleArray = [[NSMutableArray alloc] init];
    objc_setAssociatedObject(self, &type, ErrorHandleArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setServerErrorCodeHandle{
    [self setIgnoreErrorHandleForType:NSObjectIgnoreServerErrorHandle];
}
- (void)setNetworkErrorCodeHandle{
    [self setIgnoreErrorHandleForType:NSObjectIgnoreNetworkErrorHandle];
}
- (void)setDefaultErrorCodeHandle{
    [self setIgnoreErrorHandleForType:NSObjectIgnoreDefaultErrorHandle];
}
- (NSString *)explainForDefaultErrorCode:(NSString *)code{
    return [[NSErrorCodeHandle shareInstance] explainForDefaultErrorCode:code];
}

- (void)setExtraHandleErrorCodes:(NSArray *)codes forSEL:(NSString *)SELName{
    
    if(0==SELName.length) return;
    
    if(codes.count){
        NSMutableDictionary *extraCodeDict = objc_getAssociatedObject(self, &NSObjectAPIExtraErrorCode);
        if(nil==extraCodeDict){
            extraCodeDict = [[NSMutableDictionary alloc] init];
            objc_setAssociatedObject(self, &NSObjectAPIExtraErrorCode, extraCodeDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        NSMutableArray *setCodes = [[NSMutableArray alloc] initWithArray:codes];
        [extraCodeDict setObject:setCodes forKey:SELName];
    }
    
    //一旦调用设置手动处理的错误码，则设置忽略所有错误处理为nil
    objc_setAssociatedObject(self, &NSObjectIgnoreAllErrorHandle, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setOnlyHandleErrorCodes:(NSArray *)codes ignoreServerAndNetworkErrorCode:(BOOL)ignoreSNCode forSEL:(NSString *)SELName{
    if(0==SELName.length) return;
    
    [self removeDefaultErrorHandleForSEL:SELName];
    [self removeCustomErrorHandleForSEL:SELName];
    
    //处理是否忽略服务器层与网络层的处理
    if(ignoreSNCode){
        [self removeServerErrorHandleForSEL:SELName];
        [self removeNetworkErrorHandleForSEL:SELName];
    }
    //添加额外的错误码处理
    NSMutableDictionary *extraCodeDict = objc_getAssociatedObject(self, &NSObjectAPIExtraErrorCode);
    NSMutableArray *setCodes = [[NSMutableArray alloc] initWithArray:codes];
    [extraCodeDict setObject:setCodes forKey:SELName];
    
    //一旦调用设置手动处理的错误码，则设置忽略所有错误处理为nil
    objc_setAssociatedObject(self, &NSObjectIgnoreAllErrorHandle, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)extraHandleErrorCodesForSEL:(NSString *)SELName{
    
    if(0==SELName.length) return nil;
    
    NSMutableDictionary *extraCodeDict = objc_getAssociatedObject(self, &NSObjectAPIExtraErrorCode);
    if(extraCodeDict){
        NSMutableArray *codes = extraCodeDict[SELName];
        return codes;
    }
    
    return nil;
}

#pragma mark - 捕获优先级判断
- (BOOL)canIgnoreAllErrorCodeForSEL:(NSString *)SELName{
    @synchronized (self) {
        NSString *ignoreAllErrorHandle = objc_getAssociatedObject(self, &NSObjectIgnoreAllErrorHandle);
        NSMutableDictionary *extCodes = objc_getAssociatedObject(self, &NSObjectAPIExtraErrorCode);
        
        BOOL ignoreAllError = ((ignoreAllErrorHandle.length)?YES:NO);
        BOOL notExtCode = ((0==extCodes.count)?YES:NO);
        if(notExtCode&&ignoreAllError){
            NSLog(@"## catch Dimiss All Codes:%@", SELName);
            return YES;
        }
        
        return NO;
    }
}
- (BOOL)canCatchServerErrorCode:(NSString *)code forSEL:(NSString *)SELName{
    @synchronized (self) {
        if(0==SELName.length)
            return NO;
        
        NSMutableArray *ErrorHandleArray = objc_getAssociatedObject(self, &NSObjectIgnoreServerErrorHandle);
        if(nil==ErrorHandleArray){
            ErrorHandleArray = [[NSMutableArray alloc] init];
            objc_setAssociatedObject(self, &NSObjectIgnoreServerErrorHandle, ErrorHandleArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        if([ErrorHandleArray containsObject:SELName]){
            return NO;
        }
        BOOL catch = [[NSErrorCodeHandle shareInstance] canCatchServerErrorCode:code];
        if(catch){
            NSLog(@"## ignore Server Codes:%@,%@",code, SELName);
            return YES;
        }
        return NO;
    }
}
- (BOOL)canCatchNetworkErrorCode:(NSString *)code forSEL:(NSString *)SELName{
    @synchronized (self) {
        if(0==SELName.length)
            return NO;
        
        NSMutableArray *ErrorHandleArray = objc_getAssociatedObject(self, &NSObjectIgnoreNetworkErrorHandle);
        if(nil==ErrorHandleArray){
            ErrorHandleArray = [[NSMutableArray alloc] init];
            objc_setAssociatedObject(self, &NSObjectIgnoreNetworkErrorHandle, ErrorHandleArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        if([ErrorHandleArray containsObject:SELName]){
            return NO;
        }
        BOOL catch = [[NSErrorCodeHandle shareInstance] canCatchNetworkErrorCode:code];
        if(catch){
            NSLog(@"## catch Network Codes:%@,%@",code, SELName);
            return YES;
        }
        return NO;
    }
}
- (BOOL)canCatchDefaultErrorCode:(NSString *)code forSEL:(NSString *)SELName{
    @synchronized (self) {
        if(0==SELName.length)
            return NO;
        
        NSMutableArray *ErrorHandleArray = objc_getAssociatedObject(self, &NSObjectIgnoreDefaultErrorHandle);
        if(nil==ErrorHandleArray){
            ErrorHandleArray = [[NSMutableArray alloc] init];
            objc_setAssociatedObject(self, &NSObjectIgnoreDefaultErrorHandle, ErrorHandleArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        if([ErrorHandleArray containsObject:SELName]){
            return NO;
        }
        BOOL catch = [[NSErrorCodeHandle shareInstance] canCatchDefaultErrorCode:code];
        if(catch){
            NSLog(@"## ignore Default Codes:%@,%@",code, SELName);
            return YES;
        }
        return NO;
    }
}
- (BOOL)canCatchManulErrorCode:(NSString *)code forSEL:(NSString *)SELName{
    @synchronized (self) {
        if(0==SELName.length)
            return NO;
        
        NSMutableDictionary *extraCodeDict = objc_getAssociatedObject(self, &NSObjectAPIExtraErrorCode);
        if(extraCodeDict){
            NSMutableArray *extCodes = extraCodeDict[SELName];
            if(0==extCodes.count){
                return NO;
            }
            if([extCodes containsObject:code]){
                NSLog(@"## catch Manul Codes:%@,%@",code, SELName);
                return YES;
            }
        }
        return NO;
    }
}

@end
