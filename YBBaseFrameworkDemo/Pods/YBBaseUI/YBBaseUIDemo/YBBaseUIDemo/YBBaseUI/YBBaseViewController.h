//
//  YBBaseViewController.h
//  YBNet
//
//  Created by asance on 2017/4/27.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBBaseViewController : UIViewController
/**can user this property to handle some things which only once execute*/
@property(assign, nonatomic) BOOL viewDidAppear;
/**can user this property to handle some things which should dependent on higher-level controller*/
@property(copy, nonatomic) NSString *rootViewController;
/**can user this property to handle some things when view disapper*/
@property(copy, nonatomic) void(^onViewDisappearBlock)(void);

/**Remove the top offset, ios7 effective*/
- (void)setCleanEdgesForExtendedLayout;
/**Set the Rect of the current view*/
- (void)setCurFrame:(CGRect)curFrame;


/**Custom back button*/
- (void)setCustomBackItem;
/**Custom back button callback method*/
- (void)onCustomBackAction;

/**Custom left button*/
- (void)setCustomLeftItemWithTitle:(NSString *)title;
/**Custom left button callback method*/
- (void)onCustomLeftAction;

/**Custom right button*/
- (void)setCustomRightItemWithTitle:(NSString *)title;
/**Custom right button callback method*/
- (void)onCustomRightAction;

/**Return to the root controller*/
- (void)popToRootViewController;
@end
