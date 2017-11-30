//
//  YBErrorPageView.m
//  YoubanAgent
//
//  Created by asance on 2017/5/25.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBErrorPageView.h"
#import "UIColor+HexInt.h"
#import "NSNumber+LayoutAdaptation.h"

#define kErrorPageViewTag (19191)

@implementation YBErrorPageView

+ (void)showNoDataErrorWithReloadHandler:(void(^)(void))reloadHandler onView:(UIView *)onView topOffset:(CGFloat)topOffset{
    if(!onView) return;
    [YBErrorPageView dismissOnView:onView];
    
    YBErrorPageView *view = [[YBErrorPageView alloc] initWithFrame:CGRectMake(0, topOffset, CGRectGetWidth(onView.frame), CGRectGetHeight(onView.frame)-topOffset)];
    view.errImageView.image = [UIImage imageNamed:@"error_nodata_bg"];
    view.errDesLabel.text = @"没有相关记录";
    view.reloadHandler = reloadHandler;
    view.tag = kErrorPageViewTag;
    [onView addSubview:view];
}

+ (void)showNoDataErrorWithReloadHandler:(void(^)(void))reloadHandler onView:(UIView *)onView{
    if(!onView) return;
    [YBErrorPageView dismissOnView:onView];
    
    YBErrorPageView *view = [[YBErrorPageView alloc] initWithFrame:onView.bounds];
    view.errImageView.image = [UIImage imageNamed:@"error_nodata_bg"];
    view.errDesLabel.text = @"没有相关记录";
    view.reloadHandler = reloadHandler;
    view.tag = kErrorPageViewTag;
    [onView addSubview:view];
}

+ (void)showNoNetErrorWithReloadHandler:(void (^)(void))reloadHandler onView:(UIView *)onView{
    if(!onView) return;
    [YBErrorPageView dismissOnView:onView];
    
    YBErrorPageView *view = [[YBErrorPageView alloc] initWithFrame:onView.bounds];
    view.errImageView.image = [UIImage imageNamed:@"error_net_bg"];
    view.errDesLabel.text = @"网络异常，请刷新重试";
    view.reloadHandler = reloadHandler;
    view.tag = kErrorPageViewTag;
    [onView addSubview:view];
}

+ (void)showServerErrorWithReloadHandler:(void(^)(void))reloadHandler onView:(UIView *)onView{
    if(!onView) return;
    [YBErrorPageView dismissOnView:onView];
    
    YBErrorPageView *view = [[YBErrorPageView alloc] initWithFrame:onView.bounds];
    view.errImageView.image = [UIImage imageNamed:@"error_net_bg"];
    view.errDesLabel.text = @"服务器异常，请刷新重试";
    view.reloadHandler = reloadHandler;
    view.tag = kErrorPageViewTag;
    [onView addSubview:view];
}

+ (void)showNoDataErrorWithReloadHandler:(void (^)(void))reloadHandler{

    [YBErrorPageView dismissOnView:[UIApplication sharedApplication].keyWindow];
    
    CGFloat edge = 0;
    
    YBErrorPageView *view = [[YBErrorPageView alloc] initWithFrame:CGRectMake(0, edge, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-edge)];
    view.errImageView.image = [UIImage imageNamed:@"error_nodata_bg"];
    view.errDesLabel.text = @"没有相关记录";
    view.reloadHandler = reloadHandler;
    view.tag = kErrorPageViewTag;

    [[UIApplication sharedApplication].keyWindow addSubview:view];

}
+ (void)showServerErrorWithReloadHandler:(void(^)(void))reloadHandler{
    
    [YBErrorPageView dismissOnView:[UIApplication sharedApplication].keyWindow];
    
    CGFloat edge = 0;

    YBErrorPageView *view = [[YBErrorPageView alloc] initWithFrame:CGRectMake(0, edge, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-edge)];
    view.errImageView.image = [UIImage imageNamed:@"error_net_bg"];
    view.errDesLabel.text = @"服务器异常，请刷新重试";
    view.reloadHandler = reloadHandler;
    view.tag = kErrorPageViewTag;
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

+ (void)showNoNetErrorWithReloadHandler:(void (^)(void))reloadHandler{

    [YBErrorPageView dismissOnView:[UIApplication sharedApplication].keyWindow];

    CGFloat edge = 0;
    
    YBErrorPageView *view = [[YBErrorPageView alloc] initWithFrame:CGRectMake(0, edge, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-edge)];
    view.errImageView.image = [UIImage imageNamed:@"error_net_bg"];
    view.errDesLabel.text = @"网络异常，请刷新重试";
    view.reloadHandler = reloadHandler;
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

+ (void)dismissOnView:(UIView *)onView{
    YBErrorPageView *view = [onView viewWithTag:kErrorPageViewTag];
    if(view){
        [view removeFromSuperview];
    }
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.errImageView];
        [self addSubview:self.errDesLabel];
        [self addSubview:self.reloadButton];
    }
    return self;
}

- (void)onReloadAction:(UIButton *)sender{
    if(self.reloadHandler){
        self.reloadHandler();
    }
    [self removeFromSuperview];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.errImageView.frame = CGRectMake(0, 0, 140, 140);
    self.errImageView.center = CGPointMake(CGRectGetWidth(self.frame)*0.5, CGRectGetHeight(self.frame)*0.4);
    
    self.errDesLabel.frame = CGRectMake(0, CGRectGetMaxY(self.errImageView.frame), CGRectGetWidth(self.frame), 30);
    
    self.reloadButton.frame = CGRectMake(0, CGRectGetMaxY(self.errDesLabel.frame)+10, 110, 37);
    self.reloadButton.center = CGPointMake(self.errImageView.center.x, self.reloadButton.center.y);
}

#pragma mark - Getter Setter
- (UIImageView *)errImageView{
    if(!_errImageView){
        _errImageView = [[UIImageView alloc] init];
        _errImageView.userInteractionEnabled = YES;
        _errImageView.image = [UIImage imageNamed:@""];
    }
    return _errImageView;
}
- (UILabel *)errDesLabel{
    if(!_errDesLabel){
        _errDesLabel = [[UILabel alloc] init];
        _errDesLabel.userInteractionEnabled = YES;
        _errDesLabel.text = @"没有相关记录";
        _errDesLabel.textAlignment = NSTextAlignmentCenter;
        _errDesLabel.textColor = [UIColor hexColor:@"C7CDD3"];
        _errDesLabel.font = [UIFont systemFontOfSize:[NSNumber adaptToHeight:14]];
    }
    return _errDesLabel;
}
- (UIButton *)reloadButton{
    if(!_reloadButton){
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadButton.backgroundColor = [UIColor hexColor:@"5D7EAC"];
        _reloadButton.titleLabel.font = [UIFont systemFontOfSize:[NSNumber adaptToHeight:14]];
        [_reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_reloadButton setTitle:@"刷新" forState:UIControlStateNormal];
        [_reloadButton addTarget:self action:@selector(onReloadAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadButton;
}

@end
