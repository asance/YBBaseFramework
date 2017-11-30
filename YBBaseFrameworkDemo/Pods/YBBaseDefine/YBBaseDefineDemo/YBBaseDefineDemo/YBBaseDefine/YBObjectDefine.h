//
//  YBObjectDefine.h
//  DDKuaiqian
//
//  Created by asance on 2017/8/16.
//  Copyright © 2017年 asance. All rights reserved.
//

#ifndef YBObjectDefine_h
#define YBObjectDefine_h

#ifdef __OBJC__

/**
 * AppDelegate 对象
 */
#define YBAppDelegateIntance (AppDelegate *)[UIApplication sharedApplication].delegate

/**
 * 宏生成属性，
 * YBClass 类名
 * intanceName 对象名
 */
#define YBPropertyStrongSetter(YBClass, intanceName) @property(strong, nonatomic) YBClass *intanceName

/**
 * 宏生成属性，
 * YBClass 类名
 * intanceName 对象名
 */
#define YBPropertyCopySetter(YBClass, intanceName) @property(copy, nonatomic) YBClass *intanceName

/**
 * 宏生成属性，
 * YBClass 类名
 * intanceName 对象名
 */
#define YBPropertyCopyReadOnlySetter(YBClass, intanceName) @property(copy, nonatomic, readonly) YBClass *intanceName

/**
 * 宏生成属性，
 * YBClass 类名
 * intanceName 对象名
 */
#define YBPropertyAssignSetter(YBClass, intanceName) @property(assign, nonatomic) YBClass intanceName

/**
 * 宏生成UILabel，
 * getterName getter方法名
 * intanceName 内部变量名
 * setText 文本
 * setTextColor 文本颜色
 * alignment 文本对齐方式
 * font 文本字体
 */
#define YBLabelGetter(getterName, intanceName, fontSize, setText, setTextColor, alignment) \
- (UILabel *)getterName{\
if(intanceName==nil){\
intanceName = [[UILabel alloc] initWithFrame:CGRectZero];\
intanceName.font = fontSize;\
intanceName.text = setText;\
intanceName.textColor = setTextColor;\
intanceName.textAlignment = alignment;\
}\
return intanceName;\
}\

/**
 * 宏生成UIView，
 * getterName getter方法名
 * intanceName 内部变量名
 * setBackgroundColor 背景颜色
 */
#define YBViewGetter(getterName, intanceName, setBackgroundColor) \
- (UIView *)getterName{\
if(intanceName==nil){\
intanceName = [[UIView alloc] initWithFrame:CGRectZero];\
intanceName.backgroundColor = setBackgroundColor;\
}\
return intanceName;\
}\

/**
 * 宏生成UIImageView，
 * getterName getter方法名
 * intanceName 内部变量名
 * setImage 图片
 */
#define YBImageViewGetter(getterName, intanceName, setImage) \
- (UIImageView *)getterName{\
if(intanceName==nil){\
intanceName = [[UIImageView alloc] initWithFrame:CGRectZero];\
intanceName.userInteractionEnabled = YES;\
intanceName.image = setImage;\
}\
return intanceName;\
}\

/**
 * 宏生成UITableView，
 * YBClass 类名
 * intanceName 对象名
 */
#define YBTableViewGetter(intanceName, target, registerCells) \
- (UITableView *)myTableView{\
if(!_myTableView){\
_myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];\
_myTableView.backgroundColor = [UIColor whiteColor];\
_myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;\
_myTableView.delegate = target;\
_myTableView.dataSource = target;\
\
for(NSInteger i=0;i<registerCells.count;i++){\
[_myTableView registerClass:NSClassFromString(registerCells[i]) forCellReuseIdentifier:registerCells[i]];\
}\
}\
return _myTableView;\
}\

/**
 * 宏生成自定义UIView，
 * YBCustomView 自定义UIView类名
 * getterName getter方法名
 * intanceName 内部变量名
 * setBackgroundColor 背景颜色
 */
#define YBCustomViewGetter(YBCustomView, getterName, intanceName, setBackgroundColor) \
- (YBCustomView *)getterName{\
if(intanceName==nil){\
intanceName = [[YBCustomView alloc] initWithFrame:CGRectZero];\
intanceName.backgroundColor = setBackgroundColor;\
}\
return intanceName;\
}\

/**
 * 宏生成自定义NSObject，
 * YBCustomClass 自定义NSObject类名
 * getterName getter方法名
 * intanceName 内部变量名
 */
#define YBCustomClassGetter(YBCustomClass, getterName, intanceName) \
- (YBCustomClass *)getterName{\
if(intanceName==nil){\
intanceName = [[YBCustomClass alloc] init];\
}\
return intanceName;\
}\

/**
 * 建立interactor与presenter和self的关联关系
 * YBInteractorIntance 对象
 * YBPresenterIntance 对象
 * target 接收监听关联对象
 */
#define YBPiplineAssociateSetter(YBInteractorClass, YBInteractorIntance, YBPresenterClass, YBPresenterIntance, target) \
\
target.YBInteractorIntance = [YBInteractorClass new];\
\
target.YBPresenterIntance = [YBPresenterClass new];\
\
target.YBInteractorIntance.output = target.YBPresenterIntance;\
\
target.YBPresenterIntance.output = target\
\

#endif

#endif /* YBObjectDefine_h */
