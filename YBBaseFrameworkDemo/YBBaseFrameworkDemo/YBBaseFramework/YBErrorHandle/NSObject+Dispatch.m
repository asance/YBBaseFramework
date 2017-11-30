//
//  NSObject+Dispatch.m
//  YoubanAgent
//
//  Created by asance on 2017/5/17.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "NSObject+Dispatch.h"
#import <objc/runtime.h>

@implementation NSObject (Dispatch)
+ (void)dispatchAfterSeconds:(NSTimeInterval)time onMainQueue:(void (^)(void))onMainQueue{
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, time*NSEC_PER_SEC);
    dispatch_after(timer, dispatch_get_main_queue(), onMainQueue);
}
- (void)dispatchAfterSeconds:(NSTimeInterval)time onMainQueue:(void (^)(void))onMainQueue{
    [NSObject dispatchAfterSeconds:time onMainQueue:onMainQueue];
}
@end


@implementation NSObject (NullSafe)
+ (id)nullSafeForObject:(id)obj{
    if(obj==nil) {
        return @"";
    }
    
    if([obj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return obj;
}
- (id)nullSafeForObject:(id)obj{
    return [NSObject nullSafeForObject:obj];
}

@end

@implementation NSObject (Selector)
- (id)performHaveReturnSelector:(SEL)aSelector withArguments:(NSArray *)args{
    
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    if(!signature){
        NSLog(@"can't find selector:%@",NSStringFromSelector(aSelector));
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    invocation.target = self;
    
    invocation.selector = aSelector;
    
    if(args.count){
        for(NSInteger i=0;i<args.count;i++){
            id arg = args[i];
            [invocation setArgument:&arg atIndex:(i+2)];
        }
    }
    [invocation invoke];
    
    id returnValue = nil;
    const char *returnType = signature.methodReturnType;
    if(!strcmp(returnType, @encode(void))){
    }
    else if (!strcmp(returnType, @encode(id))){
        [invocation getReturnValue:&returnValue];
    }
    else{
        
    }
    return returnValue;
}
- (void)performNullReturnSelector:(SEL)aSelector withArguments:(NSArray *)args{
    
    if(NO==[self respondsToSelector:aSelector]){
        return;
    }
    
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    if(!signature){
        NSLog(@"can't find selector:%@",NSStringFromSelector(aSelector));
        return;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    invocation.target = self;
    
    invocation.selector = aSelector;
    
    if(args.count){
        for(NSInteger i=0;i<args.count;i++){
            id arg = args[i];
            [invocation setArgument:&arg atIndex:(i+2)];
        }
    }
    [invocation invoke];
}
-(BOOL)canRunToSelector:(SEL)aSelector{
    unsigned int methodCount =0;
    Method  *methodList = class_copyMethodList([self class],&methodCount);
    NSString *selectorStr = NSStringFromSelector(aSelector);
    
    BOOL result = NO;
    for (int i = 0; i < methodCount; i++) {
        Method temp = methodList[i];
        const char* selectorName =sel_getName(method_getName(temp));
        NSString *tempSelectorString = [NSString stringWithUTF8String:selectorName];
        NSLog(@"%@",tempSelectorString);
        if ([tempSelectorString isEqualToString:selectorStr]) {
            result = YES;
            break;
        }
    }
    free(methodList);
    return result;
}
@end

