//
//  ProfileNavigationCoordinator.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 26.12.16.
//  Copyright © 2016 QTUM. All rights reserved.
//

#import "ProfileNavigationCoordinator.h"

@interface ProfileNavigationCoordinator () <UIGestureRecognizerDelegate>

@end

@implementation ProfileNavigationCoordinator

- (void)viewDidLoad {

	[super viewDidLoad];

	self.navigationBar.hidden = YES;
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.interactivePopGestureRecognizer.delegate = self;
	self.interactivePopGestureRecognizer.enabled = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {

	return SLocator.appSettings.isDarkTheme ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}

@end
