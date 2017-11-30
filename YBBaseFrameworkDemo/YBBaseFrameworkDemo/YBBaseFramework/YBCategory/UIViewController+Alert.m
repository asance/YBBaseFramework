//
//  UIViewController+Alert.m
//  YoubanAgent
//
//  Created by asance on 2017/5/17.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)showAlertWithTitle:(NSString *_Nullable)title
            confirmHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))confirmHandler{
    [self showAlertWithTitle:nil
                     message:title
                confirmTitle:@"确定"
                 cancelTitle:nil
              confirmHandler:confirmHandler
               cancelHandler:nil];
}

- (void)showAlertWithTitle:(NSString *_Nullable)title
                   message:(NSString *_Nullable)message
            confirmHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))confirmHandler{
    
    [self showAlertWithTitle:title
                     message:message
                confirmTitle:@"确定"
                 cancelTitle:nil
              confirmHandler:confirmHandler
               cancelHandler:nil];
}

- (void)showAlertWithTitle:(NSString *_Nullable)title
                   message:(NSString *_Nullable)message
            confirmHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))confirmHandler
             cancelHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))cancelHandler{
    
    [self showAlertWithTitle:title
                     message:message
                confirmTitle:@"确定"
                 cancelTitle:@"取消"
              confirmHandler:confirmHandler
               cancelHandler:cancelHandler];
}

- (void)showAlertWithTitle:(NSString *_Nullable)title
                   message:(NSString *_Nullable)message
              confirmTitle:(NSString * _Nullable)confirmTitle
               cancelTitle:(NSString * _Nullable)cancelTitle
            confirmHandler:(void (^ _Nullable)(UIAlertAction * _Nonnull))confirmHandler
             cancelHandler:(void (^ _Nullable)(UIAlertAction * _Nonnull))cancelHandler{
    
    [UIViewController showAlertWithTitle:title
                                 message:message
                            confirmTitle:confirmTitle
                             cancelTitle:cancelTitle
                          confirmHandler:confirmHandler
                           cancelHandler:cancelHandler];
}

+ (void)showAlertWithTitle:(NSString *_Nullable)title
                   message:(NSString *_Nullable)message
              confirmTitle:(NSString *_Nullable)confirmTitle
               cancelTitle:(NSString *_Nullable)cancelTitle
            confirmHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))confirmHandler
             cancelHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))cancelHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if(0==confirmTitle.length) confirmTitle = @"确定";
    [alertController addAction:[UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmHandler]];
    
    if(cancelHandler){
        if(0==cancelTitle.length) cancelTitle = @"取消";
        [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler]];
    }
    
    [[UIViewController topStructureViewController] presentViewController:alertController animated:YES completion:nil];
}

+ (UIViewController *)topStructureViewController{
    
    UIViewController *currentDisplayViewController = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel!=UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *temWin in windows) {
            if (temWin.windowLevel == UIWindowLevelNormal) {
                window = temWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nestResponder = [frontView nextResponder];
    
    if ([nestResponder isKindOfClass:[UIViewController class]]) {
        //针对当前项目结构作处理
        if([nestResponder isKindOfClass:[UITabBarController class]]){
            UITabBarController *tabBarController = nestResponder;
            UIViewController *selectedViewController = tabBarController.selectedViewController;
            if(selectedViewController){
                currentDisplayViewController = selectedViewController;
            }
            else{
                currentDisplayViewController = tabBarController;
            }
        }
        else{
            currentDisplayViewController = nestResponder;
        }
    }
    else {
        currentDisplayViewController = window.rootViewController;
    }
    
    if(currentDisplayViewController.presentedViewController){
        currentDisplayViewController = currentDisplayViewController.presentedViewController;
    }
    
    return currentDisplayViewController;
}

@end

@implementation UIViewController (PhoneCall)

+ (void)openPhoneCallWithNumber:(NSString *_Nonnull)number{
    [UIViewController openPhoneCallWithNumber:number completion:nil];
}
+ (void)openPhoneCallWithDefaultNumber{
    [UIViewController openPhoneCallWithNumber:@"075526910643" completion:nil];
}

+ (void)openPhoneCallWithDefaultNumberWithCompletion:(void(^_Nullable)(BOOL success))completion{
    [UIViewController openPhoneCallWithNumber:@"075526910643" completion:completion];
}
+ (void)openPhoneCallWithNumber:(NSString *_Nonnull)number completion:(void (^ _Nullable)(BOOL))completion{
    NSString *fulNumber = [NSString stringWithFormat:@"tel://%@",number];
    NSURL *url = [NSURL URLWithString:fulNumber];

    NSString *sectionPreType0 = @"0755";
    NSString *sectionPreType1 = @"+86";
    if([number hasPrefix:sectionPreType0]){
        number = [NSString stringWithFormat:@"%@-%@",sectionPreType0,[number substringWithRange:NSMakeRange(sectionPreType0.length, number.length-sectionPreType0.length)]];
    }
    else if ([number hasPrefix:sectionPreType1]){
        number = [NSString stringWithFormat:@"%@-%@",sectionPreType1,[number substringWithRange:NSMakeRange(sectionPreType1.length, number.length-sectionPreType1.length)]];
    }
    
    if([[UIApplication sharedApplication] canOpenURL:url]){
        
        if(YES==[[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]){
            if([[UIDevice currentDevice].systemVersion floatValue]<10.3){
                [UIViewController showAlertWithTitle:@"拨打客服电话"
                                             message:number
                                        confirmTitle:nil
                                         cancelTitle:nil
                                      confirmHandler:^(UIAlertAction * _Nonnull action) {
                                          [[UIApplication sharedApplication] openURL:url];
                                          if(completion){
                                              completion(YES);
                                          }
                                      }
                                       cancelHandler:^(UIAlertAction * _Nonnull action) {
                                           if(completion){
                                               completion(NO);
                                           }
                                       }];
            }
            else{
                NSDictionary *options = @{};
                [[UIApplication sharedApplication] openURL:url options:options completionHandler:completion];
            }
        }
        else{
            [UIViewController showAlertWithTitle:@"拨打客服电话"
                                         message:number
                                    confirmTitle:nil
                                     cancelTitle:nil
                                  confirmHandler:^(UIAlertAction * _Nonnull action) {
                                      [[UIApplication sharedApplication] openURL:url];
                                      if(completion){
                                          completion(YES);
                                      }
                                  }
                                   cancelHandler:^(UIAlertAction * _Nonnull action) {
                                       if(completion){
                                           completion(NO);
                                       }
                                   }];
        }
    }
}


- (void)openPhoneCallWithNumber:(NSString *_Nonnull)number{
    [UIViewController openPhoneCallWithNumber:number];
}
- (void)openPhoneCallWithDefaultNumber{
    [UIViewController openPhoneCallWithDefaultNumber];
}

@end


@implementation UIViewController (Input)

- (void)showInputAlertWithTitle:(NSString *_Nullable)title
                        content:(NSString *_Nullable)content
                 confirmHandler:(void (^_Nullable)(NSString *_Nullable text))confirmHandler{
    
   [UIViewController showInputAlertWithTitle:title
                                     content:content
                                confirmTitle:nil
                                 cancelTitle:nil
                              confirmHandler:confirmHandler
                               cancelHandler:^(NSString * _Nullable text) {
       
   }];
}

+ (void)showInputAlertWithTitle:(NSString *_Nullable)title
                        content:(NSString *_Nullable)content
                   confirmTitle:(NSString *_Nullable)confirmTitle
                    cancelTitle:(NSString *_Nullable)cancelTitle
                 confirmHandler:(void (^_Nullable)(NSString *_Nullable text))confirmHandler
                  cancelHandler:(void (^_Nullable)(NSString *_Nullable text))cancelHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.text = content;
    }];
    
    if(0==confirmTitle.length) confirmTitle = @"确定";
    UIAlertAction *confirmActoin = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *tf = [alertController.textFields firstObject];
        
        if(confirmHandler){
            confirmHandler(tf.text);
        }
    }];
    
    [alertController addAction:confirmActoin];
    
    if(cancelHandler){
        if(0==cancelTitle.length) cancelTitle = @"取消";
        [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
    }
    
    [[UIViewController topStructureViewController] presentViewController:alertController animated:YES completion:nil];
}

@end


@implementation UIViewController (URL)

+ (void)openURLWithUrlString:(NSString *_Nonnull)urlstring{
    
    NSURL *url = [NSURL URLWithString:urlstring];
    
    if([[UIApplication sharedApplication] canOpenURL:url]){
        
        if(YES==[[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]){
            NSDictionary *options = @{};
            [[UIApplication sharedApplication] openURL:url options:options completionHandler:nil];
        }
        else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
