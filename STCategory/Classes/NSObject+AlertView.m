//
//  NSObject+AlertView.m
//  CPBaseKit
//
//  Created by MisakaTao on 2017/3/16.
//  Copyright © 2017年 misakatao. All rights reserved.
//

#import "NSObject+AlertView.h"

#define kDelegateWindow ([[UIApplication sharedApplication].delegate window])
#define kDispalyDuration    1.5f // 提示框默认显示时间

@implementation NSObject (AlertView)

+ (void)showAlertWithTarget:(id)target title:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    [target presentViewController:alertController animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDispalyDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
    });
}

+ (void)showAlertWithTitle:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    
    [[NSObject currentViewController] presentViewController:alertController animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDispalyDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
    });
}


+ (void)showAlertWithTarget:(id)target title:(NSString *)title block:(dispatch_block_t)block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [target presentViewController:alert animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDispalyDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
        block();
    });
}

+ (void)showAlertWithTitle:(NSString *)title block:(dispatch_block_t)block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [[NSObject currentViewController] presentViewController:alert animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDispalyDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
        block();
    });
}


+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actionWithTitle:(NSString *)otherTitle handler:(void (^)(UIAlertAction *action))handler

{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:handler]];
    [[NSObject currentViewController] presentViewController:alert animated:YES completion:nil];
}

+ (void)showAlertWithTarget:(id)target title:(NSString *)title message:(NSString *)message actionWithTitle:(NSString *)otherTitle handler:(void (^)(UIAlertAction *action))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:handler]];
    [target presentViewController:alert animated:YES completion:nil];
}


+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               actionTitle:(NSString *)actionTitle
          otherActionTitle:(NSString *)otherActionTitle
                   handler:(void (^)(UIAlertAction *action))handler
              otherHandler:(void (^)(UIAlertAction *action))otherHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:handler]];
    [alert addAction:[UIAlertAction actionWithTitle:otherActionTitle style:UIAlertActionStyleDefault handler:otherHandler]];
    [[NSObject currentViewController] presentViewController:alert animated:YES completion:nil];
}

+ (void)showAlertWithTarget:(id)target
                      title:(NSString *)title
                    message:(NSString *)message
                actionTitle:(NSString *)actionTitle
           otherActionTitle:(NSString *)otherActionTitle
                    handler:(void (^)(UIAlertAction *action))handler
               otherHandler:(void (^)(UIAlertAction *action))otherHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:handler]];
    [alert addAction:[UIAlertAction actionWithTitle:otherActionTitle style:UIAlertActionStyleDefault handler:otherHandler]];
    [target presentViewController:alert animated:YES completion:nil];
}


#pragma mark - Other

+ (UIViewController *)getCurrentVC {
    
    UIWindow *window = kDelegateWindow;
    // windowLevel是在 Z轴 方向上的窗口位置，默认值为UIWindowLevelNormal
    if (window.windowLevel != UIWindowLevelNormal) {
        // 获取应用程序所有的窗口
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            // 找到程序的默认窗口（正在显示的窗口）
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                // 将关键窗口赋值为默认窗口
                window = tmpWin;
                break;
            }
        }
    }
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    
    while (![nextResponder isKindOfClass:[UIViewController class]] ||
           [nextResponder isKindOfClass:[UINavigationController class]] ||
           [nextResponder isKindOfClass:[UITabBarController class]])
    {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}

+ (UIViewController *)currentViewController
{
    UIViewController *viewController = kDelegateWindow.rootViewController;
    while (1)
    {
        if ([viewController isKindOfClass:[UITabBarController class]])
        {
            viewController = [(UITabBarController *)viewController selectedViewController];
        }
        else if ([viewController isKindOfClass:[UINavigationController class]])
        {
            viewController = [(UINavigationController *)viewController visibleViewController];
        }
        else if (viewController.presentedViewController) {
            viewController = viewController.presentedViewController;
        }
        else
            break;
    }
    return viewController;
}

+ (UINavigationController *)currentNavigationController
{
    return [self currentViewController].navigationController;
}


@end
