//
//  YBLoginWindowManger.m
//  YoubanAgent
//
//  Created by asance on 2017/8/28.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBLoginWindowManger.h"
#import "YBBaseNavigationController.h"
#import "UIColor+HexInt.h"

@interface YBLoginWindowManger ()
@property(strong, nonatomic) UIWindow *myWindow;
@property(strong, nonatomic) YBBaseNavigationController *navigationController;
@end

@implementation YBLoginWindowManger

+ (instancetype)shareInstance{
    static YBLoginWindowManger *shareInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareInstance = [[YBLoginWindowManger alloc] init];
    });
    
    return shareInstance;
}

- (void)showWindowWithDismiss:(void (^)(void))dismiss{
    [self showWindowWithComplete:nil dismiss:dismiss];
}
- (void)showWindowWithComplete:(void(^)(void))complete dismiss:(void(^)(void))dismiss{
    [self cleanWindow];
    
    self.onDisplayBlock = complete;
    self.onDismissBlock = dismiss;
    self.myWindow.hidden = NO;
    
    if(nil==self.rootViewController){
        self.rootViewController = [[YBBaseViewController alloc] init];
    }
    if(NO==[self.rootViewController isKindOfClass:[YBBaseViewController class]]){
        return;
    }
    
    YBBaseViewController *transRootViewController = (YBBaseViewController *)self.rootViewController;
    if(nil==transRootViewController){
        transRootViewController = [[YBBaseViewController alloc] init];
    }
    self.navigationController = [YBBaseNavigationController rootController:transRootViewController];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor hexColor:@"0099ff"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    __weak __typeof(&*self)weakSelf = self;
    transRootViewController.onViewDisappearBlock = ^(void){
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if(!strongSelf) return;
        [strongSelf dismissWindow];
    };
    
    self.myWindow.rootViewController = self.navigationController;
    self.myWindow.tag = kLoginWindowTag;
    [self.myWindow makeKeyWindow];
    [self.navigationController.view.layer addAnimation:[self fadeAnimation] forKey:@"fade"];
    
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 0.2f*NSEC_PER_SEC);
    dispatch_after(timer, dispatch_get_main_queue(), ^{
        if(self.onDisplayBlock){
            self.onDisplayBlock();
        }
    });
}
- (void)dismissWindow{
    [self.navigationController.view.layer addAnimation:[self disRiseAnimation] forKey:@"rise"];
    
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 0.3f*NSEC_PER_SEC);
    dispatch_after(timer, dispatch_get_main_queue(), ^{
        if(self.onDismissBlock){
            self.onDismissBlock();
        }
        [self cleanWindow];
    });
}
- (void)cleanWindow{
    self.myWindow.hidden = YES;
    self.myWindow.rootViewController = nil;
    _myWindow = nil;
    
    self.navigationController = nil;
    
    self.onDisplayBlock = nil;
    self.onDismissBlock = nil;
}

#pragma mark - Getter Setter
- (UIWindow *)myWindow{
    if(!_myWindow){
        _myWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _myWindow.backgroundColor = [UIColor clearColor];
        _myWindow.hidden = YES;
    }
    return _myWindow;
}
- (CABasicAnimation *)fadeAnimation{
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    fadeAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    fadeAnimation.duration = 0.2f;
    return fadeAnimation;
}
- (CABasicAnimation *)disRiseAnimation{
    CGPoint point = self.navigationController.view.layer.position;
    CGFloat edgeCenterY = (CGRectGetHeight(self.navigationController.view.frame));
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.repeatCount = 0;
    positionAnimation.duration = 0.2f;
    positionAnimation.removedOnCompletion = NO;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:point];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y+edgeCenterY)];
    return positionAnimation;
}

@end
