//
//  YBBaseViewController.m
//  YBNet
//
//  Created by asance on 2017/4/27.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBBaseViewController.h"

#define kCustomBackBarItemTag   (9999)

@interface YBBaseViewController ()
// set iOS11 auto layout
@property(assign, nonatomic) BOOL didSetCustomBackItem;
@property(strong, nonatomic) UIButton *clearBGBackButton;
@end

@implementation YBBaseViewController

- (void)dealloc{
    [self.clearBGBackButton removeFromSuperview];
    self.clearBGBackButton = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //set default background color
    self.view.backgroundColor = [UIColor whiteColor];
    
    if([UIDevice currentDevice].systemVersion.floatValue>=11){
        self.didSetCustomBackItem = NO;
        [self setInitLeftButton];
        [self.navigationController.navigationBar addSubview:self.clearBGBackButton];
        self.clearBGBackButton.hidden = YES;
    }
    
    //clean title of backBarButtonItem
    UIBarButtonItem *backBarButtonItem=[[UIBarButtonItem alloc] init];
    backBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = backBarButtonItem;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // set iOS11 auto layout
    if([UIDevice currentDevice].systemVersion.floatValue>=11){
        if(self.didSetCustomBackItem){
            self.clearBGBackButton.hidden = NO;
        }
        else{
            self.clearBGBackButton.hidden = YES;
        }
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([UIDevice currentDevice].systemVersion.floatValue>=11){
        if(self.didSetCustomBackItem){
            self.clearBGBackButton.hidden = NO;
        }
        else{
            self.clearBGBackButton.hidden = YES;
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.clearBGBackButton.hidden = YES;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.clearBGBackButton.hidden = YES;
    
}
- (void)setCleanEdgesForExtendedLayout{
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}
- (void)setCurFrame:(CGRect)curFrame{
    
}
#pragma mark- Custom navigation Item
- (void)setCustomBackItem{
    self.didSetCustomBackItem = YES;
    //左上角返回控件,适配ios11
    if([UIDevice currentDevice].systemVersion.floatValue>=11){
        self.clearBGBackButton.hidden = NO;
    }
    else{
        self.clearBGBackButton.hidden = YES;
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        leftButton.frame = CGRectMake(0, 0, 22, 22);
        [leftButton setBackgroundImage:[UIImage imageNamed:@"back_blod"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(onCustomBackAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -12;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftBtnItem];
    }
}
- (void)onCustomBackAction{
}
- (void)setCustomRightItemWithTitle:(NSString *)title{
    if(0==title.length) title = @"完成";
    UIBarButtonItem *Item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(onCustomRightAction)];
    self.navigationItem.rightBarButtonItem = Item;
}
- (void)onCustomRightAction{
    
}
- (void)setCustomLeftItemWithTitle:(NSString *)title{
    self.didSetCustomBackItem = NO;
    UIButton *curLeftButton = (UIButton *)[self.navigationController.navigationBar viewWithTag:kCustomBackBarItemTag];
    curLeftButton.hidden = YES;
    
    if(0==title.length) title = @"取消";
    UIBarButtonItem *Item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(onCustomLeftAction)];
    self.navigationItem.leftBarButtonItem = Item;
}
- (void)setInitLeftButton{
    self.clearBGBackButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.clearBGBackButton.backgroundColor = [UIColor clearColor];
    self.clearBGBackButton.tag = kCustomBackBarItemTag;
    self.clearBGBackButton.frame = CGRectMake(0, 0, 80, 44);
    [self.clearBGBackButton setTitle:@"" forState:UIControlStateNormal];
    [self.clearBGBackButton addTarget:self action:@selector(onCustomBackAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)onCustomLeftAction{
    
}

#pragma mark- Pop to root
- (void)popToRootViewController{
    // set root viewcontroller
    if(0==self.rootViewController.length){
        self.rootViewController = @"YBHomeViewController";
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    Class vcClass = NSClassFromString(self.rootViewController);
    UIViewController *targetViewController = nil;
    
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    for(NSInteger i=0;i<viewcontrollers.count;i++){
        UIViewController *vc = viewcontrollers[i];
        if([vc isKindOfClass:vcClass]){
            targetViewController = vc;
            break;
        }
    }
    
    if(targetViewController){
        [self.navigationController popToViewController:targetViewController animated:YES];
        return;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark -
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
