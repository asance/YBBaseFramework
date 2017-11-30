//
//  YBBaseInteractor.h
//  YoubanAgent
//
//  Created by asance on 2017/8/29.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBBaseRequestWorker.h"

@interface YBBaseInteractor : NSObject
@property(strong, nonatomic) YBBaseRequestWorker *requestWorker;
@end
