//
//  UIViewController+Alert.h
//  YoubanAgent
//
//  Created by asance on 2017/5/17.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (void)showAlertWithTitle:(NSString *_Nullable)title
            confirmHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))confirmHandler;

- (void)showAlertWithTitle:(NSString *_Nullable)title
                   message:(NSString *_Nullable)message
            confirmHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))confirmHandler;

- (void)showAlertWithTitle:(NSString *_Nullable)title
                   message:(NSString *_Nullable)message
            confirmHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))confirmHandler
             cancelHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))cancelHandler;

- (void)showAlertWithTitle:(NSString *_Nullable)title
                   message:(NSString *_Nullable)message
              confirmTitle:(NSString *_Nullable)confirmTitle
               cancelTitle:(NSString *_Nullable)cancelTitle
            confirmHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))confirmHandler
             cancelHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))cancelHandler;

+ (void)showAlertWithTitle:(NSString *_Nullable)title
                   message:(NSString *_Nullable)message
              confirmTitle:(NSString *_Nullable)confirmTitle
               cancelTitle:(NSString *_Nullable)cancelTitle
            confirmHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))confirmHandler
             cancelHandler:(void(^_Nullable)(UIAlertAction * _Nonnull action))cancelHandler;

@end


@interface UIViewController (PhoneCall)

+ (void)openPhoneCallWithNumber:(NSString *_Nonnull)number;
+ (void)openPhoneCallWithDefaultNumber;

+ (void)openPhoneCallWithDefaultNumberWithCompletion:(void(^_Nullable)(BOOL success))completion;
+ (void)openPhoneCallWithNumber:(NSString *_Nonnull)number completion:(void(^_Nullable)(BOOL success))completion;


- (void)openPhoneCallWithNumber:(NSString *_Nonnull)number;
- (void)openPhoneCallWithDefaultNumber;

@end

@interface UIViewController (Input)

- (void)showInputAlertWithTitle:(NSString *_Nullable)title
                        content:(NSString *_Nullable)content
                 confirmHandler:(void (^_Nullable)(NSString *_Nullable text))confirmHandler;

+ (void)showInputAlertWithTitle:(NSString *_Nullable)title
                        content:(NSString *_Nullable)content
                   confirmTitle:(NSString *_Nullable)confirmTitle
                    cancelTitle:(NSString *_Nullable)cancelTitle
                 confirmHandler:(void (^_Nullable)(NSString *_Nullable))confirmHandler
                  cancelHandler:(void (^_Nullable)(NSString *_Nullable))cancelHandler;
@end


@interface UIViewController (URL)

+ (void)openURLWithUrlString:(NSString *_Nonnull)urlstring;

@end
