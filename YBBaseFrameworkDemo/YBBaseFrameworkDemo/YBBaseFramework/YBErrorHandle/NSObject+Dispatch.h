//
//  NSObject+Dispatch.h
//  YoubanAgent
//
//  Created by asance on 2017/5/17.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Dispatch)
/**Class method: Delay N seconds to execute the method, and callback in the main thread*/
+ (void)dispatchAfterSeconds:(NSTimeInterval)time onMainQueue:(void(^)(void))onMainQueue;
/**Instance method: Delay N seconds to execute the method, and callback in the main thread*/
- (void)dispatchAfterSeconds:(NSTimeInterval)time onMainQueue:(void(^)(void))onMainQueue;
@end

@interface NSObject (NullSafe)
/**Class method: Returns the safety object, if nil, returns @""*/
+ (id)nullSafeForObject:(id)obj;
/**Instance method: Returns the safety object, if nil, returns @""*/
- (id)nullSafeForObject:(id)obj;
@end

@interface NSObject (Selector)
/**Execute the method and return the result of the execution*/
- (id)performHaveReturnSelector:(SEL)aSelector withArguments:(NSArray *)args;
/**Execute the method and which none return*/
- (void)performNullReturnSelector:(SEL)aSelector withArguments:(NSArray *)args;
@end
