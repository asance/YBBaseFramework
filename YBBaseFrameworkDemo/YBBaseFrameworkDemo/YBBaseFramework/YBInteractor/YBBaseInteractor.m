//
//  YBBaseInteractor.m
//  YoubanAgent
//
//  Created by asance on 2017/8/29.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBBaseInteractor.h"

@implementation YBBaseInteractor

#pragma mark - Getter Setter
- (YBBaseRequestWorker *)requestWorker{
    if(!_requestWorker){
        _requestWorker = [[YBBaseRequestWorker alloc] init];
    }
    return _requestWorker;
}

@end
