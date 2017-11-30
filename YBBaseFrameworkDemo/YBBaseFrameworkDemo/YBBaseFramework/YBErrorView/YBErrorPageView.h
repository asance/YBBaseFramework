//
//  YBErrorPageView.h
//  YoubanAgent
//
//  Created by asance on 2017/5/25.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBErrorPageView : UIView

@property(strong, nonatomic) UIImageView *errImageView;
@property(strong, nonatomic) UILabel *errDesLabel;
@property(strong, nonatomic) UIButton *reloadButton;
@property(copy, nonatomic) void(^reloadHandler)(void);

+ (void)showNoDataErrorWithReloadHandler:(void(^)(void))reloadHandler;
+ (void)showNoNetErrorWithReloadHandler:(void(^)(void))reloadHandler;
+ (void)showServerErrorWithReloadHandler:(void(^)(void))reloadHandler;

+ (void)showNoDataErrorWithReloadHandler:(void(^)(void))reloadHandler onView:(UIView *)onView;
+ (void)showNoNetErrorWithReloadHandler:(void(^)(void))reloadHandler onView:(UIView *)onView;
+ (void)showServerErrorWithReloadHandler:(void(^)(void))reloadHandler onView:(UIView *)onView;

+ (void)showNoDataErrorWithReloadHandler:(void(^)(void))reloadHandler onView:(UIView *)onView topOffset:(CGFloat)topOffset;


+ (void)dismissOnView:(UIView *)onView;

@end
