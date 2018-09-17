//
//  LoginViewController.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 21.02.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import "LoginViewController.h"
#import "Presentable.h"

@interface LoginViewController () <CAAnimationDelegate, Presentable>

@property (assign, nonatomic) BOOL shoudKeboardDismiss;
@property (assign, nonatomic) BOOL editingStarted;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;

@end

static NSInteger textfieldsWithButtonHeight = 250;

@implementation LoginViewController

@synthesize delegate;

#pragma mark - Lifecycle

- (void)viewDidLoad {

	[super viewDidLoad];

	self.bottomConstraintForCancelButton.constant = self.view.frame.size.height / 2. - textfieldsWithButtonHeight / 2.;

	[self configPasswordView];

	if (self.editingStarted) {
		[self startEditing];
	}
}

- (void)didMoveToParentViewController:(UIViewController *) parent {

	[super didMoveToParentViewController:parent];
}

- (void)viewWillDisappear:(BOOL) animated {

	[super viewWillDisappear:animated];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL) animated {

	[super viewDidAppear:animated];
}

- (void)applicationWillEnterForeground {

	[self.passwordView setEditingDisabled:NO];
}

#pragma mark - Configuration

-(void)configLocalization {
    
    [self.cancelButton setTitle:NSLocalizedString(@"CANCEL", @"Cancel Button") forState:UIControlStateNormal];
    self.titleTextLabel.text = NSLocalizedString(@"Confirm PIN", @"Confirm PIN Controllers Title");
}

- (void)configPasswordView {
	self.passwordView.delegate = self;
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *) sender {

	CGRect end = [[sender userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
	self.bottomConstraintForCancelButton.constant = end.size.height;
	[self.view layoutIfNeeded];
}

- (void)keyboardWillHide:(NSNotification *) sender {
	//when comes from imessage have problems with keyboard dissmisng
//    if (!self.shoudKeboardDismiss) {
//        [self.passwordView becameFirstResponder];
//    }
}

- (void)startEditing {

	self.editingStarted = YES;
    self.shoudKeboardDismiss = NO;
	[self.passwordView becameFirstResponder];
}

- (void)stopEditing {

	self.editingStarted = NO;
    self.shoudKeboardDismiss = YES;
	[self.view endEditing:YES];
}

- (void)setInputsDisable:(BOOL) disable {
	[self.passwordView setEditingDisabled:disable];
}

- (void)clearTextFileds {

	[self.passwordView clearPinTextFields];
	[self.passwordView becameFirstResponder];
}

#pragma mark - Configuration

#pragma mark - Privat Methods

#pragma mark - PasswordViewDelegate

- (void)confirmPinWithDigits:(NSString *) digits {

	self.shoudKeboardDismiss = YES;

	if ([self.delegate respondsToSelector:@selector (passwordDidEntered:)]) {
		[self.delegate passwordDidEntered:digits];
	}
}

#pragma mark - Actions

- (IBAction)actionCancel:(id) sender {

	self.shoudKeboardDismiss = YES;
	if ([self.delegate respondsToSelector:@selector (confirmPasswordDidCanceled)]) {
		[self.delegate confirmPasswordDidCanceled];
	}
}

- (void)showLoginFields {

	self.passwordView.hidden = NO;
	self.cancelButton.hidden = NO;
	[self.passwordView becameFirstResponder];
}

- (void)applyFailedPasswordAction {

	[self.passwordView accessPinDenied];
	[self.passwordView clearPinTextFields];
	[self.passwordView becameFirstResponder];
}

@end
