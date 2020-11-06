//
//  AppDelegate.m
//  WLAppLifeCycleDemo
//
//  Created by NicoRobine on 2020/10/23.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// 返回NO的情况
// 应用程序无法处理URL资源（可以根据launchOptions确定是否时被处理URL资源启动）
// 应用程序不能继续用户活动（可以根据launchOptions确定是否时被处理用户活动启动）
//如果程序不应该处理application:performActionForShortcutItem:completionHandler:方法，因为你要在这个方法中处理主屏幕快捷操作
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    NSLog(@"%s%d%s\nlaunchOptions:%@", __FILE_NAME__, __LINE__, __FUNCTION__, launchOptions);
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%s%d%s\nlaunchOptions:%@", __FILE_NAME__, __LINE__, __FUNCTION__, launchOptions);
    return YES;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}


#pragma mark - UISceneSession lifecycle

// 返回创建新场景时场景的配置数据
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
    
    if (options.shortcutItem) {
        UISceneConfiguration* shortCutConfiguration = [[UISceneConfiguration alloc] initWithName:nil sessionRole:connectingSceneSession.role];
        shortCutConfiguration.sceneClass = [UIWindowScene class];
        shortCutConfiguration.delegateClass = NSClassFromString(@"NRShortCutScceneDelegate");
        return shortCutConfiguration;
    }
    
    
    if (options.userActivities.count > 0) {
        return [[UISceneConfiguration alloc] initWithName:@"One Configuration" sessionRole:connectingSceneSession.role];
    }
    
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

// 告诉委托对象用户已从应用切换器关闭了一个或多个应用场景
- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

#pragma mark - Life Cycle

/**
 对应通知
 
 UIApplicationDidFinishLaunchingNotification
 UIApplicationDidBecomeActiveNotification
 UIApplicationDidEnterBackgroundNotification
 UIApplicationWillEnterForegroundNotification
 UIApplicationWillResignActiveNotification
 UIApplicationWillTerminateNotification
 */

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

#pragma mark - 响应环境改变

/**
 对应通知
 
 UIApplicationProtectedDataDidBecomeAvailable
 UIApplicationProtectedDataWillBecomeUnavailable
 UIApplicationDidReceiveMemoryWarningNotification
 UIApplicationSignificantTimeChangeNotification
 */

// 受保护的文件已经可以访问
- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 受保护的文件将要变得不可访问
- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 内存警告
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 时间重大变化
- (void)applicationSignificantTimeChange:(UIApplication *)application {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

#pragma mark - 状态恢复

// 是否保存应用程序的状态
- (BOOL)application:(UIApplication *)application shouldSaveSecureApplicationState:(NSCoder *)coder {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
    return YES;
}

// 将要恢复应用程序状态，iOS6.0-13.2
- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
    return YES;
}

// 是否恢复加密的应用程序状态
- (BOOL)application:(UIApplication *)application shouldRestoreSecureApplicationState:(NSCoder *)coder {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
    return YES;
}


/**
 * @brief 要求委托对象提供指定的视图控制器
 *
 * @param identifierComponents
 与所需的视图控制器及其在视图层级中所有父视图控制器的恢复标识符相对应的NSString对象数组。 数组中的最后一个值是所需视图控制器的恢复标识符。 较早的条目表示其父视图控制器的恢复标识符。

 * @return
 要使用的视图控制器对象，如果应用程序委托不提供此视图控制器，则为nil。 如果此方法返回nil，则UIKit尝试使用可用的还原路径和情节提要信息板隐式查找视图控制器。

 * @discussion 在状态还原期间，当UIKit遇到没有还原类的视图控制器时，它将调用此方法以请求相应的视图控制器对象。此方法的实现应创建（或找到）相应的视图控制器对象并返回它。如果您的应用程序委托不提供视图控制器，则返回nil。
 */
- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
    return [UIViewController new];
}

// 告诉委托对象在状态保存过程开始时保存所有高级状态信息
// 状态保存系统在保存过程开始时调用此方法。 这是将任何应用程序级别信息添加到状态信息的机会。 例如，可能使用此方法来编写版本信息或应用程序的高级配置。
- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 告诉委托对象在状态还原过程中还原所有高级状态信息
// 状态恢复系统将此方法称为状态恢复过程的最后一步。 到调用此方法时，所有其他可恢复的对象将被还原并放回其先前的状态。
// 可以使用此方法来读取保存在应用程序中的所有使用application:willEncodeRestorableStateWithCoder:方法
// 保存的高级应用程序数据，并将其应用于您的应用程序。
- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 归档常量
// UIApplicationStateRestorationBundleVersionKey
// 创建程序恢复归档时的程序版本
// UIApplicationStateRestorationSystemVersionKey
// 创建恢复归档时的系统版本。此项的值是一个NSString对象，其中包含保存存档时安装的iOS系统版本。
// 此字符串的格式与UIDevice类的systemVersion属性中的值的格式匹配。
// UIApplicationStateRestorationTimestampKey
// 创建恢复归档时的时间戳。此项的值是一个NSDate对象，其中包含恢复存档的保存日期。 使用协调世界时（UTC）指定日期。
// UIApplicationStateRestorationUserInterfaceIdiomKey
// 创建恢复归档时的用户界面习惯用法。此项的值是一个NSNumber对象，其中包含UIUserInterfaceIdiom枚举的值之一。
// 此值反映了保存的界面是针对iPad还是iPhone习惯用法。
// UIStateRestorationViewControllerStoryboardKey
// 对包含视图控制器的storyboard的引用。该键的值是一个UIStoryboard对象，
// 该对象表示最初从中获取视图控制器的storyboard。 不需要自己将此键写入编码器。
// 每个UIViewController类在状态保存过程中自动将此密钥写入编码器。


#pragma mark - 后台下载

// 告诉应用程序如果有数据要下载，则可以开始提取操作
// 此方法在iOS13之后废弃，使用 BGAppRefreshTask 替代
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 与URLSession相关的事件正在等待处理
// 与NSURLSession对象关联的所有后台传输完成之后，无论它们成功完成还是导致错误，应用程序都会调用此方法。
// 如果一个或多个传输需要身份验证，则应用程序还会调用此方法。
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

#pragma mark - 远程通知

// iOS10之后使用UNNotification框架

// 注册远程设置成功
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 注册远程通知成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

// 注册远程通知失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 接收到远程通知，应用在前台的时候才会回调
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 告知应用程序有一个远程通知到达，该通知指示有数据要提取
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandle {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 接收到本地通知，前台调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 本地通知的Action点击回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 远程通知的Action点击回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 远程通知点击Action的回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 本地通知点击Action的回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}


// 本地通知点击Action的回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

#pragma mark - 继续用户活动和处理快捷菜单

// 继续活动的时间超过预期的时候是否通知用户
- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
    return YES;
}

// 继续活动的数据已经可以访问
// 返回本程序是否可以处理这个活动
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
    return YES;
}

// 用户活动更新
// 当UIKit管理的用户活动已更新时，在主线程上调用此方法。 可以将此方法作为将数据添加到用户活动对象的最后机会来实现
- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 活动不能继续进行
- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

// 用户为应用选择主屏幕快速操作时调用，除非启动方法中拦截了交互
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    [[UIApplication sharedApplication] requestSceneSessionActivation:nil userActivity:nil options:nil errorHandler:nil];
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

#pragma mark - Watch OS

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary * _Nullable))reply {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

#pragma mark - HealthKit

// 程序请求访问用户HealthKit数据的回调
// 在此方法的实现中，调用HKHealthStore对象的handleAuthorizationForExtensionWithCompletion:方法。
- (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

#pragma mark - URL

// 打开由URL指定的资源，并提供启动选项字典
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
    return YES;
}

#pragma mark - 应用程序扩展

// 不允许使用指定的应用扩展程序类型
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier {
    NSLog(@"%s%d%s\nextensionPointIdentifier:%@", __FILE_NAME__, __LINE__, __FUNCTION__, extensionPointIdentifier);
    return YES;
}

#pragma mark - SiriKit
// 处理Siri意向
- (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void (^)(INIntentResponse * _Nonnull))completionHandler {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
    
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"WLAppLifeCycleDemo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSLog(@"%s%d%s", __FILE_NAME__, __LINE__, __FUNCTION__);
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
