//
//  AppDelegate.m
//  qtum wallet
//
//  Created by Sharaev Vladimir on 29.10.16.
//  Copyright © 2016 QTUM. All rights reserved.
//

#import "AppDelegate.h"
#import "Appearance.h"

@interface AppDelegate ()

@property (assign, nonatomic) BOOL aplicationCoordinatorStarted;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions {

	SLocator.iOSSessionManager;
	[ServiceLocator sharedInstance];
	[SLocator.appSettings setup];
	[Appearance setUp];

	[[ApplicationCoordinator sharedInstance] startSplashScreen];
	dispatch_after (dispatch_time (DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue (), ^{

		if (!self.aplicationCoordinatorStarted) {
			[[ApplicationCoordinator sharedInstance] start];
			self.aplicationCoordinatorStarted = YES;
		}
	});

	return YES;
}

- (BOOL)application:(UIApplication *) app openURL:(NSURL *) url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *) options {

	[SLocator.openURLManager launchFromUrl:url];
	self.aplicationCoordinatorStarted = YES;
	return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *) application {

	[SLocator.popupService dismissLoader];
	[[ApplicationCoordinator sharedInstance] startConfirmPinFlowWithHandler:nil];
}

#pragma mark - Notifications

- (void)application:(UIApplication *) application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *) deviceToken {
	[SLocator.notificationManager application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *) application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
	[SLocator.notificationManager application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *) application didReceiveRemoteNotification:(NSDictionary *) userInfo {
	[SLocator.notificationManager application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *) application didReceiveRemoteNotification:(NSDictionary *) userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result)) completionHandler {
	[SLocator.notificationManager application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

@end
