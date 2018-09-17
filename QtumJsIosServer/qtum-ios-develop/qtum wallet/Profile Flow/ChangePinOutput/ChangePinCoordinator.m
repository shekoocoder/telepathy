//
//  ChangePinCoordinator.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 26.07.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import "ChangePinCoordinator.h"
#import "ChangePinOutput.h"

@interface ChangePinCoordinator () <ChangePinOutputDelegate>

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, weak) NSObject <ChangePinOutput> *pinOutput;
@property (strong, nonatomic) NSString *pinNew;
@property (strong, nonatomic) NSString *pinOld;

@end

@implementation ChangePinCoordinator

- (instancetype)initWithNavigationController:(UINavigationController *) navigationController {

	self = [super init];
	if (self) {
		_navigationController = navigationController;
	}
	return self;
}

- (void)start {

	NSObject <ChangePinOutput> *output = [SLocator.controllersFactory createChangePinController];
	output.delegate = self;
	[self.navigationController pushViewController:[output toPresent] animated:YES];
	self.pinOutput = output;
}

#pragma mark - ChangePinOutputDelegate

- (void)confirmPin:(NSString *) pin andCompletision:(void (^)(BOOL success)) completision {

	if (!self.pinOutput.passwordView.isValidPasswordLenght) {

		completision (NO);
		[self enteringPinFailed];

	} else if (!self.pinOld) {
		if ([SLocator.walletManager verifyPin:pin]) {
			//old pin confirmed
			self.pinOld = pin;
			[self.pinOutput.passwordView setStyle:SameStyle lenght:LongType];
			[self.pinOutput.passwordView clearPinTextFields];
			[self.pinOutput.passwordView becameFirstResponder];
			[self.pinOutput setCustomTitle:NSLocalizedString(@"Enter New PIN", "")];
		} else {
			completision (NO);
			[self.pinOutput.passwordView actionIncorrectPin];
			[self.pinOutput setCustomTitle:NSLocalizedString(@"Enter Old PIN", "")];
		}
	} else if (!self.pinNew) {
		//entered new pin
		self.pinNew = pin;
		[self.pinOutput.passwordView setStyle:SameStyle lenght:LongType];
		[self.pinOutput.passwordView clearPinTextFields];
		[self.pinOutput.passwordView becameFirstResponder];
		[self.pinOutput setCustomTitle:NSLocalizedString(@"Repeat New PIN", "")];

	} else {

		if ([self.pinNew isEqualToString:pin]) {
			//change pin for new one
			if (![SLocator.walletManager changePinFrom:self.pinOld toPin:self.pinNew]) {

				completision (NO);
				[self enteringPinFailed];
			} else {
				self.pinOld = nil;
				self.pinNew = nil;
				[self.delegate coordinatorDidFinish:self];
			}

		} else {
			//confirming pin failed
			completision (NO);
			[self enteringPinFailed];
		}
	}
}

- (void)enteringPinFailed {

	self.pinOld = nil;
	self.pinNew = nil;
	[self.pinOutput.passwordView setStyle:SameStyle lenght:SLocator.appSettings.isLongPin ? LongType : ShortType];
	[self.pinOutput.passwordView actionIncorrectPin];
	[self.pinOutput setCustomTitle:NSLocalizedString(@"Enter Old PIN", "")];
}

- (void)didPressedBack {

	[self.delegate coordinatorDidFinish:self];
}

- (void)didPressedCancel {

	[self.delegate coordinatorDidFinish:self];
}

@end
