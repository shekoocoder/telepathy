//
//  Appearance.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 13.12.16.
//  Copyright © 2016 QTUM. All rights reserved.
//

#import "Appearance.h"
#import "UIImage+Extension.h"
#import "NSUserDefaults+Settings.h"

@implementation Appearance

+ (void)setUp {

	if ([NSUserDefaults isDarkSchemeSetting]) {
		[self configDarkAppearance];
	} else {
		[self configLightAppearance];
	}
}

#pragma mark - Dark Appearance

+ (void)configDarkAppearance {

	[[SVProgressHUD appearance] setDefaultStyle:SVProgressHUDStyleCustom];
	[[SVProgressHUD appearance] setForegroundColor:customBlackColor ()];
	[[SVProgressHUD appearance] setBackgroundColor:customRedColor ()];
	[[SVProgressHUD appearance] setDefaultMaskType:SVProgressHUDMaskTypeBlack];
	[[SVProgressHUD appearance] setMinimumDismissTimeInterval:1];
	[[SVProgressHUD appearance] setCornerRadius:0];

	[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: customBlueColor (),
					NSFontAttributeName: [UIFont fontWithName:@"simplonmono-regular" size:11.0f]}
											 forState:UIControlStateNormal];
	[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: customBlueColor (),
					NSFontAttributeName: [UIFont fontWithName:@"simplonmono-regular" size:11.0f]}
											 forState:UIControlStateSelected];
	//color for text in searchfield
	[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName: customBlueColor (),
			NSFontAttributeName: [UIFont fontWithName:@"simplonmono-regular" size:15.0f]}];

	//color for placeholder in searchfield
	[[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:customBlueColor ()];
	[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setClearButtonMode:UITextFieldViewModeNever];
	[[UITextField appearance] setKeyboardAppearance:UIKeyboardAppearanceDark];
	[[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: customBlueColor (),
					NSFontAttributeName: [UIFont fontWithName:@"simplonmono-regular" size:16.0f]}
												forState:UIControlStateNormal];

	[[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
					NSFontAttributeName: [UIFont fontWithName:@"simplonmono-regular" size:16.0f]}
																						forState:UIControlStateNormal];

	[[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName: customBlueColor (),
					NSFontAttributeName: [UIFont fontWithName:@"simplonmono-regular" size:16.0f]}
																					  forState:UIControlStateNormal];

	//colors for toolbar
	[[UIToolbar appearance] setBarTintColor:customBlackColor ()];
	[[UIToolbar appearance] setTintColor:customBlueColor ()];


	[self configTabbarUndeline];
	[self configTabbarToplineDark];
}

+ (void)configTabbarUndeline {

	UIView *view = [[UIView alloc] initWithFrame:CGRectMake ([UITabBar appearance].frame.origin.x, [UITabBar appearance].frame.origin.y, 50, 56)];
	UIImageView *border = [[UIImageView alloc] initWithFrame:CGRectMake (view.frame.origin.x, view.frame.size.height - 6, 50, 6)];
	border.backgroundColor = customBlueColor ();
	[view addSubview:border];
	UIImage *img = [UIImage changeViewToImage:view];
	[[UITabBar appearance] setSelectionIndicatorImage:img];
	[[UITabBar appearance] setTintColor:customBlueColor ()];
}

+ (void)configTabbarToplineDark {

	UIView *view = [[UIView alloc] initWithFrame:CGRectMake (0, 0, 1, 1)];
	view.backgroundColor = customBlueColor ();
	UIImage *img = [UIImage changeViewToImage:view];
	[[UITabBar appearance] setBackgroundImage:[UIImage new]];
	[[UITabBar appearance] setShadowImage:img];
}

#pragma mark - Light Appearance

+ (void)configLightAppearance {

	[[SVProgressHUD appearance] setDefaultStyle:SVProgressHUDStyleCustom];
	[[SVProgressHUD appearance] setForegroundColor:lightGreenColor ()];
	[[SVProgressHUD appearance] setBackgroundColor:[UIColor whiteColor]];
	[[SVProgressHUD appearance] setDefaultMaskType:SVProgressHUDMaskTypeBlack];
	[[SVProgressHUD appearance] setMinimumDismissTimeInterval:1];
	[[SVProgressHUD appearance] setCornerRadius:5];

	[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: lightGrayColor (),
					NSFontAttributeName: [UIFont fontWithName:@"ProximaNova-Regular" size:11.0f]}
											 forState:UIControlStateNormal];
	[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: lightDarkGrayColor (),
					NSFontAttributeName: [UIFont fontWithName:@"ProximaNova-Regular" size:11.0f]}
											 forState:UIControlStateSelected];
	//color for text in searchfield
	[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
			NSFontAttributeName: [UIFont fontWithName:@"ProximaNova-Regular" size:16.0f]}];

	//color for placeholder in searchfield
	[[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
	[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setClearButtonMode:UITextFieldViewModeWhileEditing];
	[[UITextField appearance] setKeyboardAppearance:UIKeyboardAppearanceLight];

	[[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
					NSFontAttributeName: [UIFont fontWithName:@"ProximaNova-Light" size:14.0f]}
																						forState:UIControlStateNormal];

	[[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName: lightGreenColor (),
					NSFontAttributeName: [UIFont fontWithName:@"ProximaNova-Light" size:14.0f]}
																					  forState:UIControlStateNormal];


	//colors for toolbar
	[[UIToolbar appearance] setBarTintColor:[UIColor whiteColor]];
	[[UIToolbar appearance] setTintColor:lightGreenColor ()];

	[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setBackgroundColor:[UIColor colorWithRed:255 / 255.f green:255 / 255.f blue:255 / 255.f alpha:0.16]];


	[self configTabbarToplineLight];
	[self configTabbarUndelineLight];
}

+ (void)configTabbarUndelineLight {

	UIView *view = [[UIView alloc] initWithFrame:CGRectMake ([UITabBar appearance].frame.origin.x, [UITabBar appearance].frame.origin.y, 50, 56)];
	UIImageView *border = [[UIImageView alloc] initWithFrame:CGRectMake (view.frame.origin.x, view.frame.size.height - 6, 50, 6)];
	border.backgroundColor = [UIColor clearColor];
	[view addSubview:border];
	UIImage *img = [UIImage changeViewToImage:view];
	[[UITabBar appearance] setSelectionIndicatorImage:img];
	[[UITabBar appearance] setTintColor:customBlueColor ()];
}

+ (void)configTabbarToplineLight {

	UIView *view = [[UIView alloc] initWithFrame:CGRectMake (0, 0, 1, 1)];
	view.backgroundColor = lightTabBarTopLineColor ();
	UIImage *img = [UIImage changeViewToImage:view];
	[[UITabBar appearance] setBackgroundImage:[UIImage new]];
	[[UITabBar appearance] setShadowImage:img];
}

@end
