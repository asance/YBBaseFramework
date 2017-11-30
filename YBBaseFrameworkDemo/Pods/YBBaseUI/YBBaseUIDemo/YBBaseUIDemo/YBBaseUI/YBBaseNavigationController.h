//
//  YBBaseNavigationController.h
//  YoubanLoan
//
//  Created by asance on 2017/6/30.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBBaseViewController.h"

@protocol YBBaseNavigationControllerDelegate;

@interface YBBaseNavigationController : UINavigationController
@property(weak, nonatomic) id<YBBaseNavigationControllerDelegate> myDelegate;
/**return YBBaseNavigationController instance by specified viewcontroller*/
+ (YBBaseNavigationController *)rootControllerForName:(NSString *)vcName;
/**return YBBaseNavigationController instance by specified viewcontroller*/
+ (YBBaseNavigationController *)rootController:(YBBaseViewController *)viewcontroller;
@end

@protocol YBBaseNavigationControllerDelegate <NSObject>
/**should callback when viewcontroller will disappear*/
- (void)navigationControllerWillDisappear;
@end
