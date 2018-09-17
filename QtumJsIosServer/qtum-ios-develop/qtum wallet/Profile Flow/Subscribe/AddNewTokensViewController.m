//
//  AddNewTokensViewController.m
//  qtum wallet
//
//  Created by Sharaev Vladimir on 18.05.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import "AddNewTokensViewController.h"
#import "TextFieldWithLine.h"

const CGFloat TextFieldAlpha = 0.3f;

@interface AddNewTokensViewController () <UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet TextFieldWithLine *tokenAddressTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation AddNewTokensViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector (keyboardWillShow:)
												 name:UIKeyboardWillShowNotification
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector (keyboardWillHide:)
												 name:UIKeyboardWillHideNotification
											   object:nil];

	self.tokenAddressTextField.delegate = self;
	self.scrollView.delegate = self;
}

- (void)dealloc {

	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications Handlers

- (void)keyboardWillShow:(NSNotification *) sender {
	CGRect end = [[sender userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIEdgeInsets insets = UIEdgeInsetsMake (0.0f, 0.0f, end.size.height, 0.0f);
	self.scrollView.contentInset = insets;
}

- (void)keyboardWillHide:(NSNotification *) sender {
	self.scrollView.contentInset = UIEdgeInsetsZero;
}

#pragma mark - Actions

#pragma UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *) textField {
	[textField resignFirstResponder];
	return YES;
}

#pragma maek - UIScrollViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *) scrollView {
	[self.tokenAddressTextField resignFirstResponder];
}

@end
