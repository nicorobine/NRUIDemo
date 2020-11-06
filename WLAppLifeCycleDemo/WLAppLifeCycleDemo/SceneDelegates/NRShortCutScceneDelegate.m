//
//  NRShortCutScceneDelegate.m
//  WLAppLifeCycleDemo
//
//  Created by NicoRobine on 2020/11/6.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRShortCutScceneDelegate.h"
#import "AppDelegate.h"
#import "NRShorCutViewController.h"

@implementation NRShortCutScceneDelegate

#pragma - 场景大小、方向和特征改变的回调

- (void)windowScene:(UIWindowScene *)windowScene didUpdateCoordinateSpace:(id<UICoordinateSpace>)previousCoordinateSpace interfaceOrientation:(UIInterfaceOrientation)previousInterfaceOrientation traitCollection:(UITraitCollection *)previousTraitCollection {
    NSLog(@"%s%d%s\nScene:%@\nPreviousCoordinateSpace:%@\nPreviousInterfaceOrientation:%@\nPreviousTraitCollection:%@", __FILE_NAME__, __LINE__, __FUNCTION__, windowScene, previousCoordinateSpace, @(previousInterfaceOrientation), previousTraitCollection);
}

// 响应用户的快捷操作
- (void)windowScene:(UIWindowScene *)windowScene performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    NSLog(@"%s%d%s\nScene:%@\nShortcutItem:%@", __FILE_NAME__, __LINE__, __FUNCTION__, windowScene, shortcutItem);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completionHandler(YES);
    });
}

// 可以访问CloudKit
- (void)windowScene:(UIWindowScene *)windowScene userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata {
    NSLog(@"%s%d%s\nScene:%@\nCloudKitShareMetadata:%@", __FILE_NAME__, __LINE__, __FUNCTION__, windowScene, cloudKitShareMetadata);
}

#pragma mark - 生命周期 UISceneDelegate

// 场景将要添加到应用程序
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    self.window.rootViewController = [[NRShorCutViewController alloc] initWithNibName:NSStringFromClass([NRShorCutViewController class]) bundle:nil];
    
    
    UISceneActivationConditions* activationConditions = [[UISceneActivationConditions alloc] init];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF BEGINWITH %@", @"com.nicorobine.shortcut"];
    activationConditions.canActivateForTargetContentIdentifierPredicate = [NSPredicate predicateWithValue:@NO];
    activationConditions.prefersToActivateForTargetContentIdentifierPredicate = predicate;
    scene.activationConditions = activationConditions;
    NSLog(@"%s%d%s\nScene:%@\nSession:%@\nConnectionOptions:%@", __FILE_NAME__, __LINE__, __FUNCTION__, scene, session, connectionOptions);
    
    [self.window makeKeyAndVisible];
}

// UIKit移除了应用程序的场景
- (void)sceneDidDisconnect:(UIScene *)scene {
    NSLog(@"%s%d%s\nScene:%@", __FILE_NAME__, __LINE__, __FUNCTION__, scene);
}

// 场景进入活跃状态
- (void)sceneDidBecomeActive:(UIScene *)scene {
    NSLog(@"%s%d%s\nScene:%@", __FILE_NAME__, __LINE__, __FUNCTION__, scene);
}

// 场景进入非活跃状态
- (void)sceneWillResignActive:(UIScene *)scene {
    NSLog(@"%s%d%s\nScene:%@", __FILE_NAME__, __LINE__, __FUNCTION__, scene);
}

// 场景将要进入前台运行
- (void)sceneWillEnterForeground:(UIScene *)scene {
    NSLog(@"%s%d%s\nScene:%@", __FILE_NAME__, __LINE__, __FUNCTION__, scene);
}

// 场景已经进入后台运行
- (void)sceneDidEnterBackground:(UIScene *)scene {
    NSLog(@"%s%d%s\nScene:%@", __FILE_NAME__, __LINE__, __FUNCTION__, scene);
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    // Save changes in the application's managed object context when the application transitions to the background.
    [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}

#pragma mark - URL

// 要求委托打开一个或多个URL
- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
    NSLog(@"%s%d%s\nURLContexts:%@", __FILE_NAME__, __LINE__, __FUNCTION__, URLContexts);
}

#pragma mark - 用户活动

// 告诉委托即将接收与Handoff相关的数据
- (void)scene:(UIScene *)scene willContinueUserActivityWithType:(NSString *)userActivityType {
    NSLog(@"%s%d%s\nUserActivityType:%@", __FILE_NAME__, __LINE__, __FUNCTION__, userActivityType);
}

// 告诉委托处理与Handoff相关的指定活动
- (void)scene:(UIScene *)scene continueUserActivity:(NSUserActivity *)userActivity {
    NSLog(@"%s%d%s\nUserActivity:%@", __FILE_NAME__, __LINE__, __FUNCTION__, userActivity);
}

// 用户活动不能继续
- (void)scene:(UIScene *)scene didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    NSLog(@"%s%d%s\nUserActivityType:%@", __FILE_NAME__, __LINE__, __FUNCTION__, userActivityType);
}

#pragma mark - 状态保存

// 返回一个封装了指定场景当前状态的用户活动对象
- (NSUserActivity *)stateRestorationActivityForScene:(UIScene *)scene {
    NSLog(@"%s%d%s\nScene:%@", __FILE_NAME__, __LINE__, __FUNCTION__, scene);
    return [[NSUserActivity alloc] initWithActivityType:@"com.nicorobine.activity.test"];
}

// 用户活动已经更新
- (void)scene:(UIScene *)scene didUpdateUserActivity:(NSUserActivity *)userActivity {
    NSLog(@"%s%d%s\nUserActivity:%@", __FILE_NAME__, __LINE__, __FUNCTION__, userActivity);
}

@end
