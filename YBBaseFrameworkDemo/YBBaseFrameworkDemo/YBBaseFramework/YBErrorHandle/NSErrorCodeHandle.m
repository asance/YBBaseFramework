//
//  NSErrorCodeHandle.m
//  test_CodeReview
//
//  Created by asance on 2017/8/31.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "NSErrorCodeHandle.h"

@interface NSErrorCodeHandle ()
@property(strong, nonatomic) NSMutableArray *serverErrorCodeArray;
@property(strong, nonatomic) NSMutableArray *networkErrorCodeArray;
@property(strong, nonatomic) NSMutableDictionary *defaultErrorCodeDictionary;

@end

@implementation NSErrorCodeHandle

+ (instancetype)shareInstance{
    static NSErrorCodeHandle *shareInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareInstance = [[NSErrorCodeHandle alloc] init];
    });
    return shareInstance;
}

- (BOOL)canCatchServerErrorCode:(NSString *)code{
    if([self.serverErrorCodeArray containsObject:code]){
        return YES;
    }
    return NO;
}
- (BOOL)canCatchNetworkErrorCode:(NSString *)code{
    if([self.networkErrorCodeArray containsObject:code]){
        return YES;
    }
    return NO;
}
- (BOOL)canCatchDefaultErrorCode:(NSString *)code{
    NSArray *keys = [self.defaultErrorCodeDictionary allKeys];
    if([keys containsObject:code]){
        return YES;
    }
    return NO;
}
- (NSString *)explainForDefaultErrorCode:(NSString *)code{
    if(0==code.length)
        return @"";
    NSString *value = self.defaultErrorCodeDictionary[code];
    if(0==value.length){
        return @"";
    }
    return value;
}

#pragma mark - Getter Setter
- (NSMutableArray *)serverErrorCodeArray{
    if(!_serverErrorCodeArray){
        _serverErrorCodeArray = [[NSMutableArray alloc] init];
        [_serverErrorCodeArray addObject:@"1004"];
    }
    return _serverErrorCodeArray;
}
- (NSMutableArray *)networkErrorCodeArray{
    if(!_networkErrorCodeArray){
        _networkErrorCodeArray = [[NSMutableArray alloc] init];
        [_networkErrorCodeArray addObject:@"1009"];
    }
    return _networkErrorCodeArray;
}
- (NSMutableDictionary *)defaultErrorCodeDictionary{
    if(!_defaultErrorCodeDictionary){
        _defaultErrorCodeDictionary = [[NSMutableDictionary alloc] init];
        [_defaultErrorCodeDictionary setObject:@"该帐号已经在其它设备登录" forKey:@"400"];
        [_defaultErrorCodeDictionary setObject:@"该帐号已经在其它设备登录" forKey:@"401"];
        [_defaultErrorCodeDictionary setObject:@"该帐号已经被冻结" forKey:@"440"];
        [_defaultErrorCodeDictionary setObject:@"该帐号已经被冻结" forKey:@"201"];
        [_defaultErrorCodeDictionary setObject:@"该用户已经被冻结" forKey:@"210"];
    }
    return _defaultErrorCodeDictionary;
}
@end
